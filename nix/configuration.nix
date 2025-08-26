{ config, lib, pkgs, ... }:{
imports =
    [
      ./hardware-configuration.nix    
      ./pkgs/packages.nix
      #./pkgs/packages-notebook.nix
      ./services/services.nix     
      ./zapret-flymer/zapret.nix
      ./user/user.nix
      ./programs/programs.nix     
      #./programs/notebook.nix 
    ];
      virtualisation.waydroid.enable = true;
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
      #  VK_ICD_FILENAMES=/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json;
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
          xdg-desktop-portal-gnome
        ];
};  
systemd.user.services.polkit-gnome-authentication-agent-1 = {
  description = "Polkit GNOME Authentication Agent";
  wantedBy = [ "graphical-session.target" ];
  wants = [ "graphical-session.target" ];
  after = [ "graphical-session.target" ];
  serviceConfig = {
    Type = "simple";
    ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
    Restart = "on-failure";
    RestartSec = 1;
    TimeoutStopSec = 10;
  };
};
 system.stateVersion = "25.05"; # Did you read the comment?
}

