{ config, pkgs, ... }: {
    home = {
            username = "flaemer";
            homeDirectory = "/home/flaemer";
            stateVersion = "25.05";
            
        }; 
          
	imports = [
		./home-manager/niri/config.nix
		./home-manager/other/kitty.nix
		./home-manager/other/fuzzel.nix
		./home-manager/other/fastfetch.nix
    ./home-manager/other/themes.nix
  
		./home-manager/eww/eww.nix
	];
  
programs.fish = {
enable = true;
shellAliases = 
let
	flakePath = "/home/flaemer/nix/";
in {
rebuild = "sudo nixos-rebuild switch -I nixos-config=/home/flaemer/nix/configuration.nix"; #ребилд системы
home-switch = "home-manager switch --flake ${flakePath}"; #ребилд хоума ну замена чистка короче хоум менеджер
nix-clean = "nix-collect-garbage -d"; # чистка от старого
nix-shell = "nix-shell -p"; # никс шелл это
nixos-update = "nixos-rebuild switch --upgrade"; # обнова
nix-update = "sudo nix-channel --update && flatpak update --user"; # абнова никпгс и флатпак апсов
fastfetch-minimal = "fastfetch --config /home/flaemer/.config/fastfetch/config-minimal.jsonc"; # минимал фаст фетч
histgrep = "history | grep ";
		};
	};         
}


