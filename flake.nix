{
	description = "A simple NIxOS flake";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
		nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
	
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ self, nixpkgs, home-manager, ... }: { 
		nixosConfigurations = {
	 		david-nixos-desktop = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					./hosts/david-desktop
					./modules/common-settings.nix
					./modules/remote-server.nix
					./modules/reboot-script.nix

					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.david = import ./home/david.nix;
					}
				];
			};			
			david-nuc = nixpkgs.lib.nixosSystem {
				system = "x86_64-linux";
				modules = [
					 ./hosts/david-nuc
					 ./modules/common-settings.nix
					 ./modules/remote-server.nix

					home-manager.nixosModules.home-manager
					{
						home-manager.useGlobalPkgs = true;
						home-manager.useUserPackages = true;
						home-manager.users.david = import ./home/david.nix;
					}
				];
					 
			};
		};
		
	};
}

