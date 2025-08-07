#packages for me


{ pkgs, ...}:{


environment.systemPackages = with pkgs; [
vim
feh
home-manager
wget
git
btop


qbittorrent-enhanced

#это ну нири да да правда
niri
qemu


#themes bro
adwaita-qt
arc-theme
papirus-icon-theme
nautilus
 material-design-icons
 material-icons
fastfetch #poxvastati
xwayland-satellite

#internetik
ayugram-desktop
firefox
vesktop


ipset
iptables
iproute2
zapret


lite-xl
#кнопачки медиа там
playerctl
brightnessctl
wireplumber

#это ну работа не фейк да да у меня нет ее ну медиа музыка видео там
lollypop
obs-studio
mpv


#программы ну для вм всяких
wlogout
waybar
swaynotificationcenter
swaylock
fuzzel
#терминал и терминальное
kitty
grim
xwayland
slurp
wl-clipboard
polkit
swww
cliphist
nix-prefetch-github

#hyprland
hyprpolkitagent
hyprlock
hypridle

#ну теперь это рандом да
lmms

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
];

fonts.fontconfig.defaultFonts.emoji = ["Noto Color Emoji"]; 

# Steam 
programs.steam = {
enable = true;
remotePlay.openFirewall = true; 
dedicatedServer.openFirewall = true; 
gamescopeSession.enable = true;
};
}
