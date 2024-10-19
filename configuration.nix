# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:{

	imports = [ # Include the results of the hardware scan.
		./hardware-configuration.nix
		./graphical.nix
		./home-manager/home-manager.nix
		./environment_sys_pkgs.nix
	];


	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelParams = [
		"modprobe.blacklist=dvb_usb_rtl28xxu"
	];
	boot.initrd.systemd.network.wait-online.enable = false;

	# Disable all forms of hibernation, totally optional
	systemd.targets.hibernate.enable = false;
	systemd.targets.hybrid-sleep.enable = false;

	systemd.network.wait-online.enable = false;

	# services.displayManager.defaultSession is in graphical.nix
	# and so is services.picom.enable

	services.tailscale.enable = true;

	# Enable CUPS
	services.printing.enable = true;

	services.blueman.enable = true;


	hardware.pulseaudio.enable = true;
	services.pipewire.enable = false;
	hardware.bluetooth.enable = true;
	hardware.bluetooth.powerOnBoot = true;
	hardware.rtl-sdr.enable = true;
	security.rtkit.enable = true; # required for prior line, forgot which one
	hardware.enableAllFirmware = true;
	hardware.enableRedistributableFirmware = true;


  	# Set time zone
	time.timeZone = "America/Chicago";
	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	i18n.extraLocaleSettings = {
		LC_ADDRESS = "en_US.UTF-8";
		LC_IDENTIFICATION = "en_US.UTF-8";
		LC_MEASUREMENT = "en_US.UTF-8";
		LC_MONETARY = "en_US.UTF-8";
		LC_NAME = "en_US.UTF-8";
		LC_NUMERIC = "en_US.UTF-8";
		LC_PAPER = "en_US.UTF-8";
		LC_TELEPHONE = "en_US.UTF-8";
		LC_TIME = "en_US.UTF-8";
	};
	fonts.packages = with pkgs; [
		nerdfonts
		ezra-sil
	];

  	networking.hostName = "nixos";
	networking.networkmanager.enable = true;
	networking.interfaces.enp5s0.useDHCP = false;
	networking.firewall.enable = false;

	nixpkgs.config.allowUnfree = true;
	nix.settings.experimental-features = [ "nix-command" "flakes"];

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "unstable"; # Did you read the comment?
}
