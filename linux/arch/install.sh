# @REF: https://nobodyzxc.github.io/2019/06/06/arch-install/#more
# @REF: https://wiki.archlinux.org/title/Installation_guide
# @REF: https://zhuanlan.zhihu.com/p/107135290

set -ex

# UPDATE SYSTEM CLOCK
timedatectl set-ntp true

# VARIABLE DEFINITION
HDLOC=/dev/nvme0n1
ROOTSIZE=32G
SWAPSIZE=16G
UEFISIZE=250M
NEWHOSTNAME=cya
USERNAME=cya
ROOTPASS=root
USERPASS=user

# CHANGE TTY FONT
# list all console fonts: ls /usr/share/kbd/consolefonts/
setfont ter-218b.psf.gz

# HARD DISK PARTITION
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

# FORMAT
mkfs.vfat ${HDLOC}p1
mkfs.ext4 ${HDLOC}p2
mkfs.ext4 ${HDLOC}p4
mkswap ${HDLOC}p3
swapon ${HDLOC}p3

# MOUNT
mount ${HDLOC}p2 /mnt
mkdir /mnt/boot
mount ${HDLOC}p1 /mnt/boot
mkdir /mnt/home
mount ${HDLOC}p4 /mnt/home

# MIRROR SELECTION
# @REF: https://wiki.archlinux.org/title/Reflector
# Use 'reflector' to find the fastest 15 sources to override /etc/pacman.d/mirrorlist
reflector --verbose --latest 15 --sort rate --save /etc/pacman.d/mirrorlist

# INSTALL BASE & KERNEL
pacstrap /mnt base linux linux-firmware

# FSTAB
genfstab -U /mnt >> /mnt/etc/fstab

# TIME ZONE
arch-chroot /mnt ln -s -f /usr/share/zoneinfo/Asia/Taipei /etc/localtime
arch-chroot /mnt hwclock --systohc

# LOCALIZATION
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

# ADD USER
arch-chroot /mnt pacman -Syy --noconfirm --needed sudo
sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL\:ALL)\s\+ALL\)/\1/' /mnt/etc/sudoers
arch-chroot /mnt useradd -m -u 1001 $USERNAME
arch-chroot /mnt usermod $USERNAME -G wheel
arch-chroot /mnt bash -c "echo root:$ROOTPASS | chpasswd"
arch-chroot /mnt bash -c "echo ${USERNAME}:${USERPASS} | chpasswd"

# GRUB
# @REF: https://wiki.archlinux.org/title/GRUB
arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt pacman -S --noconfirm --needed grub os-prober efibootmgr
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg # warnning here

# NETWORK
arch-chroot /mnt pacman -S --noconfirm --needed net-tools wireless_tools
arch-chroot /mnt pacman -S --noconfirm --needed wpa_supplicant openssh
arch-chroot /mnt pacman -S --noconfirm --needed networkmanager network-manager-applet
arch-chroot /mnt systemctl enable NetworkManager.service
# arch-chroot /mnt pacman -S --noconfirm --needed dhclient dhcpcd
# arch-chroot /mnt systemctl enable dhcpcd.service

# OFFICIAL PACKAGES
HYPRLAND="hyprland hyprpaper"
SYSTOOL="pulseaudio brightnessctl copyq fastfetch dunst"
INPUT="ibus ibus-chewing"
RUSTTOOL="lsd ripgrep bottom"
TERM="kitty"
EDITOR="gvim emacs neovim"
GUITOOL="pcmanfm waybar"
FONT="ttf-hack-nerd ttf-roboto-mono-nerd ttf-jetbrains-mono-nerd noto-fonts-cjk"
arch-chroot /mnt sudo pacman -S --noconfirm --needed $HYPRLAND $SYSTOOL $INPUT $RUSTTOOL $TERM $EDITOR $GUITOOL $FONT

# YAY
# @REF: https://github.com/Jguer/yay
arch-chroot /mnt pacman -S --noconfirm --needed git base-devel
arch-chroot /mnt sudo -u $USERNAME bash -c "cd && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"

# AUR PACKAGES
AURBROWSER="google-chrome microsoft-edge-stable-bin"
AUREDITOR="visual-studio-code-bin"
AURHYPRLAND="hyprlock hyprshot hypridle"
AURGUITOOL="rofi-wayland"
AURFONT="ttf-tw ttf-ms-fonts ttf-google-fonts ttf-monaco otf-monego-git"
arch-chroot /mnt sudo -u $USERNAME bash -c "yay -S --sudoloop $AURBROWSER $AUREDITOR $AURHYPRLAND $AURGUITOOL $AURFONT"
