#!/bin/bash
#антиэто ну там вроде хз ну анти кто то 
if ! ping -c 1 8.8.8.8 &> /dev/null; then
    echo "интернет нада братанчик"
    exit 1
fi
### 1. Настройка системы ###
echo "установка базы"
pacstrap /mnt base base-devel linux linux-firmware networkmanager nano git
#1.5 это ну выбор ноут или пк хз короч
    PACKAGES-BASED2="
adwaita-dark adwaita-qt5 bash-completion blueman bluez bluez-utils breeze brightnessctl btop chromium cliphist dosfstools efibootmgr 
fastfetch filelight flatpak gamemode gimp glfw gnome-disk-utility gnome-themes-extra gnu-free-fonts grim grub gvfs-mtp hyprland hyprlock 
ipset iw kate kid3 kitty krita lib32-gamemode lib32-mangohud libasound2-plugin-fftrate libsixel libva-intel-driver linux-headers lollypop ly 
mangohud mesa-utils mpv nautilus noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra obs-studio otf-font-awesome papirus-icon-theme 
pipewire-alsa pipewire-pulse playerctl polkit-gnome power-profiles-daemon protontricks pwvucontrol python-pip qbittorrent qt5-wayland radeontop 
rofi rofi-power-menu rofimoji slurp steam swaync swww ttf-dejavu ttf-fira-code ttf-fira-sans ttf-firacode-nerd ttf-font-awesome ttf-hack 
ttf-liberation ttf-nerd-fonts-symbols ttf-opensans ttf-ubuntu-font-family vulkan-radeon vulkan-tools waybar waydroid wine-staging wireless-regdb 
wireless_tools wl-clipboard xbindkeys xclip xdg-desktop-portal-hyprland xf86-video-amdgpu xf86-video-intel yt-dlp
        "
if [ "$1" = "--computer" ]; then
PACKAGES="
    xf86-video-amdgpu vulkan-radeon libva-mesa-driver mesa-utils
    networkmanager bluez bluez-utils pipewire pipewire-alsa pipewire-pulse
    hyprland xdg-desktop-portal-hyprland qt5-wayland
     btop swaync waybar rofi grim slurp wl-clipboard
    noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-firacode-nerd
    gamemode lib32-gamemode steam protontricks
    adwaita-dark gnome-themes-extra papirus-icon-theme
    fastfetch filelight flatpak qbittorrent
    vulkan-tools radeontop ly
    "
else
echo "выбери мразь sway или hyprland"
 exit 1
fi
### 2. Настройка пользователя ###
read -p "Введите имя пользователя: " username
useradd -m -G wheel,audio,video,storage,optical -s /bin/bash "$username"
echo "Установите пароль для $username:"
read -p "Введите пароль пользователя: " password
passwd "$password"
#для субо 
read -sp "Введите пароль для субо братана: " rootpass
echo "root:$rootpass" | chpasswd
unset rootpass
### 3. Настройка sudo ###
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "все этот ну вот он $username создан и теперь тоже может юзать судо"

### 4. Установка пакетов (pacman) ###
echo "установка ещоооооо"
arch-chroot /mnt
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
pacman -S --needed \
    adwaita-dark adwaita-qt5 bash-completion blueman bluez bluez-utils breeze brightnessctl btop chromium cliphist dosfstools efibootmgr \
    fastfetch filelight flatpak gamemode gimp git glfw gnome-disk-utility gnome-themes-extra gnu-free-fonts grim grub gvfs-mtp hyprland hyprlock \
    ipset iw kate kid3 kitty krita lib32-gamemode lib32-mangohud libasound2-plugin-fftrate libsixel libva-intel-driver linux-firmware \
  linux-headers lollypop ly mangohud mesa-utils mpv  nautilus networkmanager noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
   obs-studio otf-font-awesome papirus-icon-theme pipewire-alsa pipewire-pulse playerctl polkit-gnome power-profiles-daemon protontricks pwvucontrol \
    python-pip qbittorrent qt5-wayland radeontop rofi rofi-power-menu rofimoji slurp steam swaync swww ttf-dejavu ttf-fira-code ttf-fira-sans \
   ttf-firacode-nerd ttf-font-awesome ttf-hack ttf-liberation ttf-nerd-fonts-symbols ttf-opensans ttf-ubuntu-font-family vulkan-radeon \
    vulkan-tools waybar waydroid wine-staging wireless-regdb wireless_tools  wl-clipboard xbindkeys xclip xdg-desktop-portal-hyprland xf86-video-amdgpu \
    xf86-video-intel yt-dlp
echo "ну это хз гавнокод от дипсика надеюсь буде работать йау"
yay -S --noconfirm --needed adwaita-dark adwaita-qt5 ayugram-desktop-bin elyprismlauncher-bin heroic-games-launcher-bin libasound2-plugin-fftrate libgbinder libglibutil libwireplumber-4.0-compat mobydroid mobydroid-debug portproton protontricks protonup-qt-bin pwvucontrol python-gbinder python-vdf rofi-power-menu ventoy-bin ventoy-bin-debug vesktop-bin waydroid webcord yay yay-debug

#и зачем я это делаю то как будто арч каждый день переустанавливаю                # Твой пользователь
REPO="https://github.com/flaemer/flaemer.git"  # Ссылка на репозиторий
TMP_DIR="/home/$username/yaiko/"     # Временная папка
CONFIG_SOURCE="$TMP_DIR/flaemer/.config" # Откуда копировать
CONFIG_TARGET="/home/$USER/.config" # Куда копировать


### 5. Установка загрузчика (GRUB) ###
echo "мразотский загрузчик короче граб он меня бист он как гроб звучит прост"
pacman -S --noconfirm grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

### 6. запуски всякие
systemctl enable NetworkManager

### 7. Завершение ###
echo "бабах случится завтра я уверен в этом"
