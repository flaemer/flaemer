
{ config, lib, pkgs, ... }:
 
{
imports =
    [
      ./hardware-configuration.nix    
      ./packages.nix
      ./home-manager/zapret.nix
    ];
    
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

services.blueman.enable = true;
nix.settings.experimental-features = [ "nix-command" "flakes" ];
security.polkit.enable = true;
nixpkgs.config.allowUnfree = true;
services.flatpak.enable = true;
environment.variables = {
  LIBGL_ALWAYS_SOFTWARE = "0";
  GALLIUM_DRIVER = "radeonsi"; # Для AMD
};

 networking.hostName = "nixos"; 
 networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
 time.timeZone = "Asia/Krasnoyarsk";

  #services
  services.xserver.enable = true;
  services.printing.enable = true;
  services.pipewire = {
  enable = true;
  pulse.enable = true;
 };
 services.gvfs.enable = true;

 
  hardware.graphics = {
    enable = true;
     };

# User     
  users.users.flaemer = {
     isNormalUser = true;
     extraGroups = [ "wheel" "audio" "video" "disk" "network" "input" "networkmanager" "plugdev"]; 
     packages = with pkgs; [
       tree
     ];
   };

# Enable 
 programs.firefox.enable = true;
programs.waybar.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
   programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };
 hardware.bluetooth.powerOnBoot = true;
 hardware.bluetooth.enable = true;
# Xdg portal idk
xdg.portal = { 
enable = true;
wlr.enable = true;
extraPortals = with pkgs; [
xdg-desktop-portal-gtk
xdg-desktop-portal-wlr
];
};
#bluetooth
systemd.services.bluetooth = {
wantedBy = [ "multi-user.target"];
serviceConfig.Restart = "always";
};
 system.stateVersion = "25.05"; # Did you read the comment?

 
}
