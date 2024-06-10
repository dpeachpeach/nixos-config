
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

  system.stateVersion = "23.11"; # Did you read the comment?

}

