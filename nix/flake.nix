{

	description = "my first flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
			
		};
	};

	outputs = { nixpkgs, home-manager, ... }:
		let 
 		system = "x86_64-linux";
		in {
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem { 
	         	inherit system;
		modules = [ ./configuration.nix ];
     };
	homeConfigurations.flaemer = home-manager.lib.homeManagerConfiguration {
		pkgs = nixpkgs.legacyPackages.${system};
		modules = [ ./home.nix ];
	          };
		};
	}

