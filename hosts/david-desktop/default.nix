
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  # systemd-boot configuration
  boot.loader.systemd-boot.editor = false;

  programs.ssh.startAgent = true;
  
  # turn off sleeping
  powerManagement.enable = false;

  networking.hostName = "david-nixos-desktop"; # Define your hostname.

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Chicago";

  #TODO: Abstract away most of these into separate files once I get back home from boston.

  # Base system packages i want to install.
  environment.systemPackages = with pkgs; [
     tailscale #remote server
     waybar
     dunst
     libnotify
     swww
     alacritty
     rofi-wayland
     firefox
  ];

  ## Graphics: I have a Nvidia GPU on my desktop so I need to allow unfree + configure
  
  nixpkgs.config.allowUnfree = true;
  
  hardware.opengl = { 
     enable = true;
     driSupport = true;
     driSupport32Bit = true;
  }; 

  
  hardware.nvidia = { 
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false; 
    nvidiaSettings = true;

  };

	## GUI
	services.xserver = {
		enable = true;
		videoDrivers = ["nvidia"];
		displayManager.gdm = {
			enable = true;
			wayland = true;
		};
	};
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	environment.sessionVariables = {
		WLR_NO_HARDWARE_CURSORS = "1";
		NIXOS_OZONE_WL = "1";
	};
	
	xdg.portal.enable = true;
	xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

	## Sound

	sound.enable = true;
	security.rtkit.enable = true;



  ## Users TODO: add tati
  users.users.david = {
	name = "david";
	isNormalUser = true;
        shell = pkgs.fish;
        home = "/home/david";
        extraGroups = ["networkmanager" "wheel"];
        openssh.authorizedKeys.keys = with (import ../../modules/ssh.nix); [ 
	macbook
	];
  };

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

  system.stateVersion = "23.11"; # Did you read the comment?

}

