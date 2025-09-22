#packages for me
{ pkgs, ...}:{


environment.systemPackages = with pkgs; [


polkit_gnome 
pamixer
file-roller

mako
niri
eww
xwayland-satellite

#themes bro
adwaita-qt
arc-theme
papirus-icon-theme
material-design-icons
material-icons

nautilus

#internetik
chromium
vesktop
materialgram

lite-xl


#это ну работа не фейк да да у меня нет ее ну медиа музыка видео там
lollypop
obs-studio
mpv

#программы ну для вм всяких
fuzzel

#терминал и терминальное
kitty
wl-clipboard
swww
cliphist

hyprlock

#гамес ого какая кнопочка №№№ № № № №№ №№№  
gamemode 
mangohud
gamescope
steam-run

 # возможно сделать отдельным конфигом под спорные ибо ну спорные много зависимостей и ненужны
 # типо зачем мне вайн на пк где мне лишь зайти в игру и все надо бы порт протон или чего нить найти
 # или скрипт под протон 
libsForQt5.kdenlive
wineWowPackages.waylandFull
winetricks

blueman
pwvucontrol
];
}   

