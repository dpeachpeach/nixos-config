{ config, pkgs, ... }:

{
	imports = [
		./modules/bundle.nix
	];

	home = {
		username = "david";
		homeDirectory = "/home/david";
		stateVersion = "23.11";
	};
	
	programs.home-manager.enable = true;

	home.packages  = with pkgs; [
		fastfetch
	];
		
}
