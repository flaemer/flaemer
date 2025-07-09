### 4. Установка пакетов (pacman)
    git clone https://aur.archlinux.org/yay-bin.git
    cd yay-bin
    makepkg -si --noconfirm
pacman -S --needed \
 bash-completion blueman bluez bluez-utils breeze brightnessctl btop chromium cliphist dosfstools efibootmgr \
    fastfetch filelight flatpak gamemode gimp glfw gnome-disk-utility gnome-themes-extra gnu-free-fonts grim grub gvfs-mtp hyprland hyprlock \
    ipset iw kate kid3 kitty krita lib32-gamemode lib32-mangohud libsixel libva-intel-driver \
  lollypop ly mangohud mesa-utils mpv nautilus noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra \
   obs-studio otf-font-awesome papirus-icon-theme pipewire-alsa pipewire-pulse playerctl polkit-gnome power-profiles-daemon \
    python-pip qbittorrent qt5-wayland radeontop rofi rofimoji slurp steam swaync swww ttf-dejavu ttf-fira-code ttf-fira-sans \
   ttf-firacode-nerd ttf-font-awesome ttf-hack ttf-liberation ttf-nerd-fonts-symbols ttf-opensans ttf-ubuntu-font-family vulkan-radeon \
    vulkan-tools waybar wl-clipboard xbindkeys xclip xdg-desktop-portal-hyprland xf86-video-amdgpu \
    xf86-video-intel yt-dlp
# yay -S --noconfirm --needed adwaita-dark adwaita-qt5 ayugram-desktop-bin elyprismlauncher-bin heroic-games-launcher-bin libasound2-plugin-fftrate libgbinder libglibutil libwireplumber-4.0-compat mobydroid mobydroid-debug portproton protontricks protonup-qt-bin pwvucontrol python-gbinder python-vdf rofi-power-menu ventoy-bin ventoy-bin-debug vesktop-bin waydroid webcord yay yay-debug


### 5. Установка загрузчика (GRUB)
echo "egg"
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

### 6. запуски всякие
systemctl enable NetworkManager

#конфиги
REPO="https://github.com/flaemer/flaemer.git"  # Ссылка на репозиторий
TMP_DIR="/home/$username/yaiko/"     # Временная папка
CONFIG_SOURCE="$TMP_DIR/flaemer/.config" # Откуда копировать
CONFIG_TARGET="/home/$USER/.config" # Куда копировать
git clone https://github.com/flaemer/flaemer.git $TMP_DIR
cp -r /home/$username/yaiko/.config /home/$username/
### 7. Завершение ###
echo "бабах случится завтра я уверен в этом"
