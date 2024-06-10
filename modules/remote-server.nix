{ pkgs, inputs, config, ... }:

{
	  ## Remote connectivity controls
	  services = {
		tailscale = {
			enable = true;
			port = 41641;
			openFirewall = true;
		};
		openssh = {
			enable = true;
			settings = {
				PasswordAuthentication = false;
			};
		};
	  };


	## Set up SSH keys
	  programs.ssh.startAgent = true;
	  services.gnome.gnome-keyring.enable = true;
}
