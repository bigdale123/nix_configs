{ config, pkgs, ... }:
{

	imports = [ # Include the results of the hardware scan.
		<home-manager/nixos>
		./hardware-configuration.nix
		./environment_sys_pkgs.nix
		./users.nix
		./i3.nix
		./dunst.nix
		./kitty.nix
	];

	home-manager.backupFileExtension = "bak";


	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelParams = [
		"modprobe.blacklist=dvb_usb_rtl28xxu"
		"kvm.enable_virt_at_load=0"
	];
	boot.kernelModules = ["amdgpu"];
	boot.initrd.kernelModules = ["kvm-amd"];
	
	boot.crashDump.enable = true;
	boot.kernel.sysctl."kernel.panic_on_oops" = 1;

	# graphics troubleshooting bullshit
	hardware.graphics = {
		enable = true;
	};

	# Fix for "Rebuild Error - Failed to start Network Manager Wait Online"
	systemd.network.wait-online.enable = false;
	boot.initrd.systemd.network.wait-online.enable = false;

	# Kernel Version Setting
	boot.kernelPackages = pkgs.linuxPackages_6_6;

	# Disable all forms of hibernation, totally optional
	systemd.targets.hibernate.enable = false;
	systemd.targets.hybrid-sleep.enable = false;

	

	services.tailscale.enable = true;

	virtualisation.virtualbox.host = {
		enable = true;
	};
	users.extraGroups.vboxusers.members = ["dylan"];
	

	# Enable CUPS (Printing)
	services.printing.enable = true;
	services.printing.drivers = [ pkgs.pantum-driver ];

	services.blueman.enable = true;
	services.flatpak.enable = true;
	xdg.portal.enable = true; # Needed for flatpak
	xdg.portal.extraPortals = [
		pkgs.xdg-desktop-portal-gtk
	];
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
		ezra-sil
		libre-baskerville
	] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  	networking.hostName = "nixos";
	networking.networkmanager.enable = true;
	# below line is specific for thinkpad, remove for new machines
	networking.interfaces.enp5s0.useDHCP = false;
	networking.firewall.enable = false;
	# networking.networkmanager.dns = "none";

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
