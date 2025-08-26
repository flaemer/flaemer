#packages for me
{ pkgs, ...}:{


environment.systemPackages = with pkgs; [
feh
polkit_gnome 
home-manager
wget
git
btop
ydotool
wirelesstools
pamixer
file-roller
qbittorrent-enhanced
yt-dlp

pciutils
usbutils
lm_sensors


#это ну нири да да правда
niri
eww
xwayland-satellite

wayvnc

#themes bro
adwaita-qt
arc-theme
papirus-icon-theme
nautilus
material-design-icons
material-icons

fastfetch 
#poxvastati


#internetik
firefox
vesktop
materialgram

zapret


lite-xl
#кнопачки медиа там
playerctl
wireplumber

#это ну работа не фейк да да у меня нет ее ну медиа музыка видео там
lollypop
obs-studio
mpv

#программы ну для вм всяких
fuzzel

#терминал и терминальное
kitty
wezterm
wl-clipboard
polkit
swww
cliphist
nix-prefetch-github

hyprlock

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
  vdpauinfo
  libvdpau-va-gl
  libva
  mesa
  
pwvucontrol
ffmpeg
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

