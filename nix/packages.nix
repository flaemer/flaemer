#packages for me


{ pkgs, ...}:{


environment.systemPackages = with pkgs; [
vim
feh
home-manager
wget
git
btop

#themes bro
adwaita-qt
arc-theme
papirus-icon-theme


fastfetch #poxvastati
libsForQt5.ark

#internetik
ayugram-desktop
firefox
vesktop


ipset
iptables
iproute2
zapret

nemo-with-extensions
lite-xl
#кнопачки медиа там
playerctl
light
wireplumber
#это ну работа не фейк да да у меня нет ее ну медиа музыка видео там
lollypop
obs-studio

#hyprland
wlogout
rofi-wayland
waybar
kitty
hyprpolkitagent
grim
hyprlock
wl-clipboard
hypridle
swaynotificationcenter
polkit
xwayland
swww
slurp
mpv

#гамес ого какая кнопочка №№№ № № № №№ №№№  
vinegar
prismlauncher
protontricks
protonup-qt
gamemode 
mangohud
gamescope
steam-run
wineWowPackages.waylandFull
winetricks

networkmanager
bluetui
blueman
bluez
bluez-tools

#графика
 vulkan-tools
  glxinfo
  clinfo
  radeontop
  libva-utils
  vdpauinfo
  #mesa
  
gnome-disk-utility
krita
pwvucontrol
libreoffice-qt6

];

#fonts 

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
  openmoji-color
];

# Steam 
programs.steam = {
enable = true;
remotePlay.openFirewall = true; 
dedicatedServer.openFirewall = true; 
gamescopeSession.enable = true;
};

# Hyprland       
programs.hyprland = {
enable = true;
xwayland.enable = true;
};
}
