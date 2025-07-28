{ config, pkgs, ... }: {
    home = {
            username = "flaemer";
            homeDirectory = "/home/flaemer";
            stateVersion = "25.05";
            
        }; 
          
	imports = [
		./home-manager/waybar.nix
		./home-manager/git.nix
		./home-manager/fastfetch.nix
		./home-manager/hypr/hyprland.nix
	];
  
programs.bash = {
enable = true;
shellAliases = 
let
	flakePath = "~/nix";
in {
rebuild = "sudo nixos-rebuild switch -I nixos-config=/home/flaemer/nix/configuration.nix";
home-switch = "home-manager switch --flake ${flakePath}";
	};
     };    
}


