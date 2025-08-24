{ config, lib, pkgs, ... }:
 
{
imports =
    [
      ./hardware-configuration.nix    
      ./pkgs/packages.nix
      ./services/pipewire.nix
      ./zapret-flymer/zapret.nix
      ./user/user.nix
      ./programs/steam.nix     
    ];
    
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  security.polkit.enable = true;
  nixpkgs.config.allowUnfree = true;
  
fonts.fontDir.enable = true;
   
    boot.loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
};

    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; 
        GDK_BACKEND = "wayland"; 
        SDL_VIDEODRIVER = "wayland"; 
};

    environment.variables = {
        LANG = "en_US.UTF-8";
        LC_ALL = "en_US.UTF-8";
        LC_CTYPE = "en_US.UTF-8";
    };
    
    networking = {
        hostName = "nixos"; 
        networkmanager.enable = true;  
        firewall = {
            enable = true;
            allowedTCPPorts = [ 5900 ];
            allowedUDPPorts = [ 5353 ]; 
};

    services = {
        gvfs.enable = true;
        flatpak.enable = true;
        xserver.enable = true;
        blueman.enable = true;
};
  
    programs = { 
        firefox.enable = true;
        mtr.enable = true;
};
   
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
};

    hardware = {
       bluetooth.powerOnBoot = true;
       bluetooth.enable = true;
};

    xdg.portal = { 
       enable = true;
       wlr.enable = true;
       extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
        ];
};  
 system.stateVersion = "25.05"; # Did you read the comment?
}
