#!/bin/bash

# reflector yeye
reflector --country Russia --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# Packages for pc or laptop
amd_pc="btop"
hp_notebook="grub efibootmgr os-prober hyprland rofi swaync lollypop arch-install-scripts radeontop chromium swww yt-dlp steam qbittorrent polkit-gnome playerctl obs-studio networkmanager mpv ly krita kitty kid3 kate gvfs-mtp grim hyprlock flatpak filelight fastfetch efibootmgr grub btop blueman bluez mesa mesa-utils vulkan-radeon lib32-mesa lib32-vulkan-radeon tlp tlp-rdw slurp wl-clipboard pipewire pipewire-pulse wireplumber powertop xdg-desktop-portal-hyprland gnu-free-fonts noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra otf-font-awesome papirus-icon-theme ttf-dejavu ttf-fira-code ttf-fira-sans ttf-firacode-nerd ttf-font-awesome ttf-hack ttf-liberation ttf-nerd-fonts-symbols ttf-opensans ttf-ubuntu-font-family gnome-disk-utility"
read -p "your name: " USERNAME
home="/home/$USERNAME"
base_pkgs="base base-devel linux linux-firmware nano sudo git linux-headers reflector go"
lvm_pkgs="lvm2 device-mapper"
#read -p "lvm?" package_choice


#разделы эти ну да

# Mount root razdel
read -p "Enter root part  (e.g., /dev/sda2): " root
[ -z "$root" ] && { echo "root partition not specified!"; exit 1; }
mkfs.ext4 "$root"
mount "$root" /mnt || { echo "Error mounting $root"; exit 1; }

#home razdel
read -p "Enter home  (e.g., /dev/sda3): " home
[ -z "$home" ] && { echo "home partition not specified!"; exit 1; }
mkfs.ext4 "$home"
mkdir -p /mnt/home
mount "$home" /mnt/home || { echo "Error mounting $home"; exit 1; }

#boot razdel
read -p "Enter boot part  (e.g., /dev/sda1): " boot_efi
[ -z "$boot_efi" ] && { echo "Boot partition not specified!"; exit 1; }
mkfs.vfat "$boot"
mkdir -p /mnt/boot/efi
mount "$boot_efi" /mnt/boot/efi || { echo "Error mounting $boot_efi"; exit 1; }

#lsblk for check
lsblk | grep -v "loop"
sleep 2
pacstrap /mnt $base_pkgs $lvm_pkgs
# Install base packages
#case $package_choice in
    #1) pacstrap /mnt $lvm_pkgs;;
    #*) echo "skipping";;
#esac
# Generate fstab
echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab || { echo "Failed to generate fstab"; exit 1; }

# Package selection
echo "laptor or desktop?"
echo "1) Laptop"
echo "2) Desktop" 
read -p "Your choice (1-2): " choice

#chroot часть
arch-chroot /mnt /bin/bash <<EOF

#user
GROUPS="wheel,audio,video,storage"
useradd -m -G "$GROUPS" -s /bin/bash "$USERNAME" 2>/dev/null
echo "Configuring sudo..."
echo "$USERNAME ALL=(ALL:ALL) ALL" >> /etc/sudoers || { echo "Failed to configure sudo"; exit 1; }

#еще рандомное хз я заебался
echo "[multilib]" >> /etc/pacman.conf
echo "Include = /etc/pacman.d/mirrorlist" >> /etc/pacman.conf
pacman -Sy
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
locale-gen

#yay bro
mkdir /home/$USERNAME/yay-bin
yay="yay-bin"
git clone https://aur.archlinux.org/yay-bin.git ~/$yay &&
cd ~/yay &&
makepkg -si --noconfirm

#PACKAGES
case $choice in
    1) pacman -S --noconfirm $hp_notebook;;
    2) pacman -S --noconfirm $amd_pc;;
    *) echo "Invalid choice, skipping additional packages";;
#grub памойка эта 
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

#еще пакеты эти ну да базовые да да деньги
# Установка сервисных пакетов

# Настройка сервисов
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl --user enable pipewire pipewire-pulse wireplumber
systemctl enable power-profiles-daemon
systemctl enable thermald

EOF
echo "ended"
