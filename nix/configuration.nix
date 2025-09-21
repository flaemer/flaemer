{ config, lib, pkgs, ... }:{
imports =
    [
      ./hardware-configuration.nix    
      
      ./pkgs/packages.nix
      ./pkgs/packages-fonts.nix               #fonts btw
      ./pkgs/packages-cli.nix

      ./pkgs/packages-cli-notebook.nix
      ./pkgs/packages-notebook.nix

#      ./services/printer.nix
      ./services/services.nix     
      ./zapret-flymer/zapret.nix     #zapret btw
      ./user/user.nix
      ./programs/programs.nix     
    ];
  
#  virtualisation.waydroid.enable = true;                                                                                                                                                                                                                                                                                                                                               #maybe idk i don't need this because it's loading long and tiktok working im lazy i dont need but you can be here because i allow this because i can't make normal config i need did something where is bloat like that other .nix file but i too lazy to make other .nix file and i need loggin in to github or something maybe use usb flash or other disk or local server yea i need make local server for files like videos or this because i don't will need github because i don't have peoples who will fix my config or help and i don't need this is my config ya dolboyob i need stop write

  boot.kernelPackages = pkgs.linuxPackages_latest;
  
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
          xdg-desktop-portal-gnome
        ];
};  
 system.stateVersion = "25.05"; # Did you read the comment?
}

