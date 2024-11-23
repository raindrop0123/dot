#!/bin/sh

# REF: https://nobodyzxc.github.io/2019/06/06/arch-install/#more
# REF: https://wiki.archlinux.org/title/Installation_guide
# REF: https://zhuanlan.zhihu.com/p/107135290

# 1. Boot by USB
# 2. Connect to the Internet - iwctl
# 3. curl -fsSL https://raw.githubusercontent.com/raindrop0123/dot/refs/heads/main/linux/scripts/arch_installation.sh > install.sh
# 4. chmod +x install.sh
# 5. sh install.sh

set -ex

# Update System Clock
timedatectl set-ntp true

# Variable Definition
HDLOC=/dev/nvme0n1
ROOTSIZE=32G
SWAPSIZE=16G
UEFISIZE=250M
NEWHOSTNAME=cya
USERNAME=cya
ROOTPASS=root
USERPASS=user

# Change TTY Font
# list all console fonts: ls /usr/share/kbd/consolefonts/
setfont ter-218b.psf.gz

# Hard Disk Partition
# Use 'cgdisk /dev/sda' to clean your HDD.
read -p "${USERNAME}@${NEWHOSTNAME} on $HDLOC
`lsblk`
swap size: $SWAPSIZE
root directory size: $ROOTSIZE
boot partition size: $UEFISIZE
enter to contine, ^C to stop:"
# keep track of the last executed command
trap 'last_command=$current_command; current_command=$BASH_COMMAND' DEBUG
# echo an error message before exiting
trap 'echo "\"${last_command}\" command end with exit code $?."' EXIT
(echo "g";  sleep 1; \
  echo "n";  \
  echo "1";  \
  echo "";   \
  echo "+$UEFISIZE"; sleep 1; \
  echo "n";  \
  echo "2";  \
  echo "";   \
  echo "+$ROOTSIZE"; sleep 1; \
  echo "n";  \
  echo "3";  \
  echo "";   \
  echo "+$SWAPSIZE"; sleep 1; \
  echo "n";  \
  echo "4";  \
  echo "";   \
  echo "";   sleep 1; \
  echo "t";  \
  echo "1";  \
  echo "1";  sleep 1; \
  echo "t";  \
  echo "2";  \
  echo "20"; sleep 1; \
  echo "t";  \
  echo "3";  \
  echo "19"; sleep 1; \
  echo "t";  \
  echo "4";  \
  echo "20"; sleep 5; \
  echo "w";  sleep 1;) | fdisk $HDLOC

# Formatting
mkfs.vfat ${HDLOC}p1
mkfs.ext4 ${HDLOC}p2
mkfs.ext4 ${HDLOC}p4
mkswap ${HDLOC}p3
swapon ${HDLOC}p3

# Mounting
mount ${HDLOC}p2 /mnt
mkdir /mnt/boot
mount ${HDLOC}p1 /mnt/boot
mkdir /mnt/home
mount ${HDLOC}p4 /mnt/home

# Mirror Selection
# REF: https://wiki.archlinux.org/title/Reflector
# Use 'reflector' to find the fastest 15 sources to override /etc/pacman.d/mirrorlist
# reflector --verbose --latest 15 --sort rate --save /etc/pacman.d/mirrorlist

# Install base and kernel
pacstrap /mnt base linux linux-firmware

# FSTAB
genfstab -U /mnt >> /mnt/etc/fstab

# Timezone
arch-chroot /mnt ln -s -f /usr/share/zoneinfo/Asia/Taipei /etc/localtime
arch-chroot /mnt hwclock --systohc

# Localization
sed -i "s/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /mnt/etc/locale.gen
sed -i "s/#zh_TW.UTF-8 UTF-8/zh_TW.UTF-8 UTF-8/" /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf
echo "$NEWHOSTNAME" > /mnt/etc/hostname
cat << EOF > /mnt/etc/hosts
127.0.0.1      localhost
::1            localhost
127.0.1.1      $NEWHOSTNAME.localdomain      $NEWHOSTNAME
EOF
echo "nameserver 8.8.8.8" >> /mnt/etc/resolv.conf

# Create User
arch-chroot /mnt pacman -Syy --noconfirm --needed sudo
sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL\:ALL)\s\+ALL\)/\1/' /mnt/etc/sudoers
arch-chroot /mnt useradd -m -u 1001 $USERNAME
arch-chroot /mnt usermod $USERNAME -G wheel
arch-chroot /mnt bash -c "echo root:$ROOTPASS | chpasswd"
arch-chroot /mnt bash -c "echo ${USERNAME}:${USERPASS} | chpasswd"

# GRUB
# REF: https://wiki.archlinux.org/title/GRUB
arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt pacman -S --noconfirm --needed grub os-prober efibootmgr
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg # warnning here

# Network
arch-chroot /mnt pacman -S --noconfirm --needed net-tools wireless_tools
arch-chroot /mnt pacman -S --noconfirm --needed wpa_supplicant openssh
arch-chroot /mnt pacman -S --noconfirm --needed networkmanager network-manager-applet
arch-chroot /mnt systemctl enable NetworkManager.service
# arch-chroot /mnt pacman -S --noconfirm --needed dhclient dhcpcd
# arch-chroot /mnt systemctl enable dhcpcd.service

# Official Packages
WM="awesome xorg-xinit xorg-server"
SYSTOOL="brightnessctl xclip fastfetch udiskie polkit-kde-agent pulseaudio pamixer"
INPUT="fcitx5-im fcitx5-chewing"
RUSTTOOL="lsd ripgrep bottom fzf fd"
TERM="alacritty"
EDITOR="gvim emacs neovim"
GUITOOL="pcmanfm"
FONT="ttf-victor-mono-nerd ttf-hack-nerd ttf-jetbrains-mono-nerd ttf-meslo-nerd"
FONT="$FONT ttf-noto-nerd ttf-roboto-mono-nerd ttf-terminus-nerd ttf-ubuntu-nerd"
FONT="$FONT ttf-ubuntu-mono-nerd noto-fonts-cjk"
arch-chroot /mnt sudo pacman -S --noconfirm --needed $WM $SYSTOOL $INPUT $RUSTTOOL $TERM $EDITOR $GUITOOL $FONT

# yay
# REF: https://github.com/Jguer/yay
arch-chroot /mnt pacman -S --noconfirm --needed git base-devel
arch-chroot /mnt sudo -u $USERNAME bash -c "cd && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"

# AUR Packages
AURBROWSER="google-chrome"
AUREDITOR="visual-studio-code-bin"
AURFONT="ttf-tw ttf-ms-fonts"
arch-chroot /mnt sudo -u $USERNAME bash -c "yay -S --sudoloop $AURBROWSER $AUREDITOR $AURFONT"
