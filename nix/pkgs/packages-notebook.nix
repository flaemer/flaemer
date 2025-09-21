{ pkgs, ...}:{
environment.systemPackages = with pkgs; [
mcomix
#libreoffice-qt6
krita

python314
qemu

intel-gpu-tools
intel-compute-runtime
intel-media-driver

gthumb
];
}
