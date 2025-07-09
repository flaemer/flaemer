#!/bin/bash

# Проверка на root
if [[ $EUID -ne 0 ]]; then
    echo "Этот скрипт должен запускаться от root!"
    exit 1
fi

### 1. Настройка системы ###
echo "⚙️  Установка базовых пакетов..."
pacman -Syu --noconfirm --needed \
    base base-devel linux linux-firmware networkmanager nano git

### 2. Настройка пользователя ###
read -p "Введите имя пользователя: " username
useradd -m -G wheel,audio,video,storage,optical -s /bin/bash "$username"
echo "Установите пароль для $username:"
passwd "$username"

### 3. Настройка sudo ###
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
echo "✅ Пользователь $username создан и добавлен в sudoers."

### 4. Установка пакетов (pacman) ###
echo "📦 Установка основных пакетов..."
pacman -S --noconfirm --needed \
    adwaita-dark adwaita-qt5 bash-completion blueman bluez bluez-utils \
    breeze brightnessctl btop chromium cliphist dosfstools efibootmgr \
    fastfetch filelight flatpak gamemode gimp git glfw gnome-disk-utility \
    gnome-themes-extra gnu-free-fonts grim grub gvfs-mtp hyprland hyprlock \
    ipset iw kate kid3 kitty krita lib32-gamemode lib32-mangohud \
    libasound2-plugin-fftrate libsixel libva-intel-driver linux-firmware \
    linux-headers lollypop ly mangohud mesa-utils mpv nano nautilus \
    networkmanager noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
    obs-studio otf-font-awesome papirus-icon-theme pipewire-alsa pipewire-pulse \
    playerctl polkit-gnome power-profiles-daemon protontricks pwvucontrol \
    python-pip qbittorrent qt5-wayland radeontop rofi rofi-power-menu rofimoji \
    slurp steam swaync swww ttf-dejavu ttf-fira-code ttf-fira-sans \
    ttf-firacode-nerd ttf-font-awesome ttf-hack ttf-liberation \
    ttf-nerd-fonts-symbols ttf-opensans ttf-ubuntu-font-family vulkan-radeon \
    vulkan-tools waybar waydroid wine-staging wireless-regdb wireless_tools \
    wl-clipboard xbindkeys xclip xdg-desktop-portal-hyprland xf86-video-amdgpu \
    xf86-video-intel yt-dlp

### 5. Установка загрузчика (GRUB) ###
echo "🔌 Установка GRUB..."
pacman -S --noconfirm grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

### 6. Настройка сети ###
systemctl enable NetworkManager

# ### 7. Установка yay и AUR-пакетов (после перезагрузки) ###
# echo "📌 После входа в систему выполните вручную:"
# echo "git clone https://aur.archlinux.org/yay-bin.git"
# echo "cd yay-bin && makepkg -si"
# echo "yay -S ayugram-desktop-bin elyprismlauncher-bin heroic-games-launcher-bin portproton protonup-qt-bin vesktop-bin"

### 7. Завершение ###
echo "🎉 Установка завершена! Перезагрузитесь"
