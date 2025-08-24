#packages for me
{ pkgs, ...}:{


environment.systemPackages = with pkgs; [
home-manager
wget
git
btop
ydotool
pamixer
file-roller
qbittorrent-enhanced
yt-dlp

rustdesk
pciutils
usbutils
lm_sensors

nautilus

fastfetch 
#poxvastati


#internetik
firefox
vesktop
materialgram

zapret


lite-xl
playerctl
wireplumber

#это ну работа не фейк да да у меня нет ее ну медиа музыка видео там
lollypop
obs-studio
mpv

#терминал и терминальное
wezterm
wl-clipboard
polkit
nix-prefetch-github


#гамес ого какая кнопочка №№№ № № № №№ №№№  
prismlauncher
protontricks
gamemode 
mangohud
gamescope
steam-run
wineWowPackages.waylandFull
winetricks

  networkmanager
  blueman
  bluez
  bluez-tools

  
  vulkan-tools
  glxinfo
  clinfo
  radeontop
  libva-utils
  libva
  mesa
ffmpeg

#КалДЕ
    kdePackages.sddm-kcm # Configuration module for SDDM
    kdePackages.partitionmanager # Optional Manage the disk devices, partitions and file systems on your computer
    hardinfo2 # System information and benchmarks for Linux systems
    haruna # Open source video player built with Qt/QML and libmpv
    wayland-utils # Wayland utilities
    wl-clipboard # Command-line copy/paste utilities for Wayland
];
fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        liberation_ttf
        fira-code
        fira-code-symbols
        mplus-outline-fonts.githubRelease
        dina-font
        proggyfonts
        meslo-lgs-nf
        nerd-fonts.symbols-only
  ];

}   

