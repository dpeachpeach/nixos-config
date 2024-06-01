{ pkgs, inputs, config, ... }:

{
	environment.systemPackages = with pkgs; [git vim curl];
	
	## Sudo permissions
	security.sudo.execWheelOnly = true;

	## Enable my shell in all cases
	programs.fish.enable = true;

	## Clutter mgmt
	programs.command-not-found.enable = false;

	nix = {
		optimise.automatic = true;
		settings = {
			experimental-features = ["flakes" "nix-command"];
			trusted-users  = ["@wheel"];
		};
	};
	

}
