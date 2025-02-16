#!/usr/bin/env sh

#############
# REFERENCE #
#############
# https://nobodyzxc.github.io/2019/06/06/arch-install/#more
# https://wiki.archlinux.org/title/Installation_guide
# https://zhuanlan.zhihu.com/p/107135290

########
# STEP #
########
# 1. Boot by USB
# 2. Connect to the Internet - iwctl
# 3. curl -fsSL https://raw.githubusercontent.com/raindrop0123/dot/refs/heads/main/linux/arch.sh > install.sh
# 4. chmod +x install.sh
# 5. write down your os information
# 6. sh install.sh

set -e
setfont ter-218b.psf.gz

################
# SYSTEM CLOCK #
################
timedatectl set-ntp true

#######################
# VARIABLE DEFINITION #
#######################
HDLOC=/dev/nvme0n1
ROOTSIZE=32G
SWAPSIZE=16G
UEFISIZE=250M
NEWHOSTNAME=
USERNAME=
ROOTPASS=
USERPASS=

#############
# PARTITION #
#############
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

##########
# FORMAT #
##########
mkfs.vfat ${HDLOC}p1
mkfs.ext4 ${HDLOC}p2
mkfs.ext4 ${HDLOC}p4
mkswap ${HDLOC}p3
swapon ${HDLOC}p3

#########
# MOUNT #
#########
mount ${HDLOC}p2 /mnt
mkdir /mnt/boot
mount ${HDLOC}p1 /mnt/boot
mkdir /mnt/home
mount ${HDLOC}p4 /mnt/home

##########
# MIRROR #
##########
# https://wiki.archlinux.org/title/Reflector
# Use 'reflector' to find the fastest 15 sources to override /etc/pacman.d/mirrorlist
reflector --verbose --latest 15 --sort rate --save /etc/pacman.d/mirrorlist

#########################
# INSTALL BASE & KERNEL #
#########################
pacstrap /mnt base linux linux-firmware

#########
# FSTAB #
#########
genfstab -U /mnt >> /mnt/etc/fstab

############
# TIMEZONE #
############
arch-chroot /mnt ln -s -f /usr/share/zoneinfo/Asia/Taipei /etc/localtime
arch-chroot /mnt hwclock --systohc

################
# LOCALIZATION #
################
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

###############
# CREATE USER #
###############
arch-chroot /mnt pacman -Syy --noconfirm --needed sudo
sed -i 's/^#\s*\(%wheel\s\+ALL=(ALL\:ALL)\s\+ALL\)/\1/' /mnt/etc/sudoers
arch-chroot /mnt useradd -m -u 1001 $USERNAME
arch-chroot /mnt usermod $USERNAME -G wheel
arch-chroot /mnt bash -c "echo root:$ROOTPASS | chpasswd"
arch-chroot /mnt bash -c "echo ${USERNAME}:${USERPASS} | chpasswd"

########
# GRUB #
########
# https://wiki.archlinux.org/title/GRUB
arch-chroot /mnt mkinitcpio -p linux
arch-chroot /mnt pacman -S --noconfirm --needed grub os-prober efibootmgr
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg # warnning here

###########
# NETWORK #
###########
arch-chroot /mnt pacman -S --noconfirm --needed net-tools wireless_tools
arch-chroot /mnt pacman -S --noconfirm --needed wpa_supplicant openssh
arch-chroot /mnt pacman -S --noconfirm --needed networkmanager network-manager-applet
arch-chroot /mnt systemctl enable NetworkManager.service
echo "Network services are enabled."
arch-chroot /mnt pacman -S --noconfirm --needed dhclient dhcpcd
arch-chroot /mnt systemctl enable dhcpcd.service
echo "DHCPCD services are enabled."

#############
# BLUETOOTH #
#############
arch-chroot /mnt pacman -S --noconfirm --needed bluez
arch-chroot /mnt systemctl enable bluetooth.service
echo "Bluetooth services are enabled."

####################
# OFFICIAL PACKAGE #
####################
WM="awesome xorg-xinit xorg-server"
HYPR="hyprland hyprpaper hypridle hyprlock hyprpicker hyprcursor"
SYSTOOL1="brightnessctl pulseaudio pulseaudio-alsa pamixer xclip fastfetch udiskie"
SYSTOOL2="blueman polkit-kde-agent alsa-utils flatpak"
SYSTOOL3="redshift flameshot unzip p7zip rofi tmux arandr"
INPUT="ibus ibus-chewing fcitx fcitx-chewing fcitx-configtool"
RUST="lsd ripgrep bottom fzf fd bat rust"
JS="npm"
MATE="mate mate-extra"
TERM="xterm rxvt-unicode foot"
EDITOR="emacs neovim gvim helix nano kakoune"
GUITOOL="pcmanfm lxappearance qt5ct waybar"
arch-chroot /mnt sudo pacman -S --noconfirm --needed $WM $HYPR $SYSTOOL1 $SYSTOOL2 $SYSTOOL3
arch-chroot /mnt sudo pacman -S --noconfirm --needed $INPUT $RUST $TERM $EDITOR $GUITOOL $JS $MATE
ADOBE1="adobe-source-code-pro-fonts	adobe-source-han-sans-cn-fonts adobe-source-han-sans-hk-fonts"
ADOBE2="adobe-source-han-sans-jp-fonts adobe-source-han-sans-kr-fonts adobe-source-han-sans-otc-fonts"
ADOBE3="adobe-source-han-sans-tw-fonts adobe-source-han-serif-cn-fonts"
ADOBE4="adobe-source-han-serif-hk-fonts adobe-source-han-serif-jp-fonts"
ADOBE5="adobe-source-han-serif-kr-fonts adobe-source-han-serif-otc-fonts"
ADOBE6="adobe-source-han-serif-tw-fonts adobe-source-sans-fonts adobe-source-serif-fonts"
arch-chroot /mnt sudo pacman -S --noconfirm --needed $ADOBE1 $ADOBE2 $ADOBE3
arch-chroot /mnt sudo pacman -S --noconfirm --needed $ADOBE4 $ADOBE5 $ADOBE6
WQY="wqy-bitmapfont wqy-microhei wqy-microhei-lite wqy-zenhei"
MATH="otf-latinmodern-math otf-latinmodern-math otf-latin-modern"
NOTO="noto-fonts-emoji noto-fonts-extra noto-fonts ttf-noto-nerd noto-fonts-cjk"
UBUNTU="ttf-ubuntu-mono-nerd ttf-ubuntu-nerd"
CASCADIA="ttf-cascadia-code-nerd ttf-cascadia-mono-nerd"
SYMBOLS="ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono"
LIBERATION="ttf-liberation ttf-liberation-mono-nerd"
arch-chroot /mnt sudo pacman -S --noconfirm --needed $WQY $MATH $NOTO $UBUNTU $CASCADIA $SYMBOLS $LIBERATION
INCONSOLATA="ttf-inconsolata-nerd ttf-inconsolata-go-nerd ttf-inconsolata-lgc-nerd"
DEJAVU="ttf-dejavu ttf-dejavu-nerd"
FIRA="otf-fira-mono otf-fira-sans otf-firamono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd"
FANTASQUE="ttf-fantasque-nerd ttf-fantasque-sans-mono otf-fantasque-sans-mono"
HACK="ttf-hack ttf-hack-nerd"
JETBRAINS="ttf-jetbrains-mono ttf-jetbrains-mono-nerd"
ROBOTO="ttf-roboto ttf-roboto-mono ttf-roboto-mono-nerd"
arch-chroot /mnt sudo pacman -S --noconfirm --needed $INCONSOLATA $DEJAVU $FIRA $FANTASQUE $HACK $JETBRAINS $ROBOTO
NERD1="ttf-ibmplex-mono-nerd ttf-terminus-nerd"
NERD2="ttf-iosevka-nerd ttf-meslo-nerd"
NERD3="ttf-mononoki-nerd ttf-mplus-nerd"
NERD4="ttf-victor-mono-nerd ttf-zed-mono-nerd ttf-sarasa-gothic"
arch-chroot /mnt sudo pacman -S --noconfirm --needed $NERD1 $NERD2 $NERD3 $NERD4
MISC="otf-codenewroman-nerd otf-comicshanns-nerd otf-droid-nerd otf-monaspace-nerd ttf-font-awesome"
arch-chroot /mnt sudo pacman -S --noconfirm --needed $MISC

#######
# YAY #
#######
arch-chroot /mnt pacman -S --noconfirm --needed git base-devel
arch-chroot /mnt sudo -u $USERNAME bash -c "cd && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"

########
# PARU #
########
# arch-chroot /mnt pacman -S --noconfirm --needed base-devel
# arch-chroot /mnt sudo -u $USERNAME bash -c "cd && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si"

###############
# AUR PACKAGE #
###############
AURAPP="google-chrome visual-studio-code-bin hyprland-qtutils hyprshot"
AURFONT="ttf-tw ttf-ms-fonts ttf-pt-mono otf-monego-git ttf-monaco apple-fonts otf-apple-pingfang-relaxed otf-apple-pingfang otf-stix nerd-fonts-sf-mono"
arch-chroot /mnt sudo -u $USERNAME bash -c "yay -S --sudoloop $AURAPP $AURFONT"

########
# HINT #
########
echo "ArchLinux installation is finished."
echo "Don't forget to umount all partitions."
echo "Now you should reboot you machine."
