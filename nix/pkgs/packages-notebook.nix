{ pkgs, ...}:{
environment.systemPackages = with pkgs; [
brightnessctl
mcomix
lmms
vinegar

libsForQt5.kdenlive
libreoffice-qt6
krita

intel-gpu-tools
intel-compute-runtime
intel-media-driver

qemu
];
}
