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
PKG="xorg-xinit xorg-server awesome"
PKG="$PKG xclip ibus ibus-chewing wezterm kitty alacritty"
PKG="$PKG ripgrep lsd gvim emacs neovim bottom"
PKG="$PKG alsa-utils brightnessctl pcmanfm flameshot"
arch-chroot /mnt sudo pacman -S --noconfirm --needed $PKG

FONT="noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-noto-nerd, noto-fonts-extra"
FONT="$FONT ttf-hack ttf-hack-nerd"
FONT="$FONT ttf-ibm-plex ttf-ibmplex-mono-nerd"
FONT="$FONT ttf-dejavu ttf-dejavu-nerd"
FONT="$FONT adobe-source-code-pro-fonts ttf-sourcecodepro-nerd"
FONT="$FONT ttf-inconsolata ttf-inconsolata-nerd ttf-inconsolata-go-nerd ttf-inconsolata-lgc-nerd"
FONT="$FONT ttf-ubuntu-font-family ttf-ubuntu-nerd ttf-ubuntu-mono-nerd"
FONT="$FONT ttf-roboto ttf-roboto-mono ttf-roboto-mono-nerd"
FONT="$FONT ttf-jetbrains-mono ttf-jetbrains-mono-nerd"
FONT="$FONT ttf-nerd-fonts-symbols ttf-nerd-fonts-symbols-common ttf-nerd-fonts-symbols-mono"
FONT="$FONT otf-fira-mono otf-fira-sans otf-firamono-nerd ttf-fira-code ttf-fira-mono ttf-fira-sans ttf-firacode-nerd"
FONT="$FONT otf-cascadia-code ttf-cascadia-code ttf-cascadia-code-nerd ttf-cascadia-mono-nerd"
FONT="$FONT ttc-iosevka ttf-iosevka-nerd ttf-iosevkaterm-nerd"
FONT="$FONT terminus-font ttf-terminus-nerd"
FONT="$FONT otf-fantasque-sans-mono ttf-fantasque-nerd ttf-fantasque-sans-mono"
FONT="$FONT otf-droid-nerd ttf-droid"
FONT="$FONT otf-monaspace otf-monaspace-nerd ttf-monaspace-variable"
FONT="$FONT ttf-arphic-ukai ttf-arphic-uming"
FONT="$FONT awesome-terminal-fonts ttf-font-awesome otf-font-awesome"
FONT="$FONT wqy-bitmapfont wqy-microhei wqy-microhei-lite wqy-zenhei"
FONT="$FONT inter-font cantarell-fonts ttf-victor-mono-nerd"
FONT="$FONT ttf-sarasa-gothic otf-codenewroman-nerd ttf-meslo-nerd ttf-mononoki-nerd gnu-free-fonts ttf-space-mono-nerd"
FONT="$FONT opendesktop-fonts otf-aurulent-nerd otf-comicshanns-nerd otf-commit-mono-nerd"
FONT="$FONT otf-geist-mono-nerd otf-hasklig-nerd otf-hermit-nerd otf-hermit"
FONT="$FONT otf-opendyslexic-nerd ttf-0xproto-nerd"
FONT="$FONT ttf-3270-nerd ttf-agave-nerd ttf-anonymous-pro ttf-anonymouspro-nerd"
FONT="$FONT ttf-arimo-nerd ttf-atkinson-hyperlegible ttf-baekmuk ttf-bigblueterminal-nerd"
FONT="$FONT ttf-bitstream-vera ttf-bitstream-vera-mono-nerd"
FONT="$FONT ttf-caladea ttf-carlito ttf-charis-sil ttf-cormorant ttf-cousine-nerd"
FONT="$FONT ttf-crimson ttf-crimson-pro ttf-crimson-pro-variable"
FONT="$FONT ttf-croscore ttf-d2coding-nerd ttf-daddytime-mono-nerd"
FONT="$FONT ttf-doulos-sil ttf-envycoder-nerd ttf-eurof ttf-gentium-plus"
FONT="$FONT ttf-go-nerd ttf-hanazono ttf-hannom ttf-heavydata-nerd ttf-iawriter-nerd"
FONT="$FONT ttf-indic-otf ttf-input ttf-intone-nerd ttf-joypixels ttf-junicode ttf-junicode-variable"
FONT="$FONT ttf-khmer ttf-lato ttf-lekton-nerd"
FONT="$FONT ttf-liberation ttf-liberation-mono-nerd"
FONT="$FONT ttf-lilex-nerd ttf-linux-libertine ttf-linux-libertine-g ttf-martian-mono-nerd"
FONT="$FONT ttf-mona-sans ttf-monofur ttf-monofur-nerd ttf-monoid ttf-monoid-nerd"
FONT="$FONT ttf-montserrat ttf-mplus-nerd ttf-nunito ttf-opensans ttf-overpass"
FONT="$FONT ttf-profont-nerd ttf-proggyclean-nerd ttf-sazanami ttf-scheherazade-new ttf-sharetech-mono-nerd"
FONT="$FONT ttf-tibetan-machine ttf-tinos-nerd"
FONT="$FONT adobe-source-han-sans-cn-fonts adobe-source-han-sans-hk-fonts adobe-source-han-sans-jp-fonts"
FONT="$FONT adobe-source-han-sans-kr-fonts adobe-source-han-sans-tw-fonts"
FONT="$FONT adobe-source-han-serif-cn-fonts adobe-source-han-serif-hk-fonts adobe-source-han-serif-jp-fonts"
FONT="$FONT adobe-source-han-serif-kr-fonts adobe-source-han-serif-tw-fonts"
FONT="$FONT libertinus-font libotf otf-atkinson-hyperlegible otf-aurulent-nerd"
FONT="$FONT otf-cormorant otf-crimson otf-crimson-pro ttf-indic-otf"
FONT="$FONT otf-ipaexfont otf-ipafont otf-ipamjfont otf-junicode otf-latin-modern otf-latinmodern-math"
FONT="$FONT otf-montserrat otf-opendyslexic-nerd otf-overpass otf-overpass-nerd powerline-fonts"
arch-chroot /mnt sudo pacman -S --noconfirm --needed $FONT

# YAY
# @REF: https://github.com/Jguer/yay
arch-chroot /mnt pacman -S --noconfirm --needed git base-devel
arch-chroot /mnt sudo -u $USERNAME bash -c "cd && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si"

# AUR PACKAGES
AURPKG="google-chrome visual-studio-code-bin"
arch-chroot /mnt sudo -u $USERNAME bash -c "yay -S --sudoloop $AURPKG"

AURFONT="ttf-tw ttf-ms-fonts ttf-google-fonts terminus-font-ttf ttf-vista-fonts ttf-wps-fonts ttf-icomoon-feather"
AURFONT="$AURFONT ttf-monaco otf-monego-git otf-operator-mono otf-operator-mono-lig"
AURFONT="$AURFONT ttf-segoe-ui-variable ttf-maple nerd-fonts-dm-mono cmu-sans-font-ttf"
AURFONT="$AURFONT apple-fonts ttf-mac-fonts" # ttf-mac-fonts need to install svn manually and these two packages are conflict 
AURFONT="$AURFONT ttf-mplus ttf-cmu-typewriter ttf-cmu-serif ttf-pt-mono ttf-recursive ttf-harmonyos-sans"
AURFONT="$AURFONT ttf-bookerly amazon-fonts ttf-monaco-nerd-font-git ttf-sarasa-gothic-nerd-fonts"
AURFONT="$AURFONT ttf-fixedsys-excelsior-linux"
arch-chroot /mnt sudo -u $USERNAME bash -c "yay -S --sudoloop $AURFONT"
