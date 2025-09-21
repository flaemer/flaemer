{ pkgs, ...}:{
environment.systemPackages = with pkgs; [
git
wget
btop
zapret
home-manager
nix-prefetch-github
android-tools

fastfetch 
wireplumber

playerctl
brightnessctl

ffmpeg

pciutils
usbutils
lm_sensors

polkit

networkmanager
bluez

vulkan-tools
glxinfo
clinfo
radeontop
libva-utils
vdpauinfo
libvdpau-va-gl
libva
mesa
];
}
