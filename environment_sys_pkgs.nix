# Contains system packages definition and environment definitions
{ config, pkgs, ... }: {
	virtualisation.virtualbox.host.enable = true;
	users.extraGroups.vboxusers.members = [ "dylan" ];
	environment = {
		systemPackages = with pkgs; [
			(pkgs.buildFHSUserEnv {
				name = "fhs-env";
				runscript = "bash";
				targetPkgs = pkgs: with pkgs; [
					winetricks
					wineWowPackages.staging
				];
			})
			(python3.withPackages(ps: with ps; [
				flask
				sqlite
				flask-cors
				flask-wtf
				pyshark
				requests
			]))
			conda
			gnumake
			gcc
			gdb
			zulu
			wget
			curl
			ocs-url
			tailscale
			tesseract
			imagemagick
			xsel
			maim
			xclip
			pavucontrol
			mesa
			pulseaudio
			git
			lxappearance
			libnotify
			usbutils
			zip
			gzip
			unzip
			gnutar
			qpdf
			killall
			neovim
			zulu
			dig
			pciutils
			linux-firmware
			virt-viewer
			darktable
			gnu-cobol
		];
		interactiveShellInit = "
			alias loopback-enable='pactl load-module module-loopback latency_msec=1'
			alias loopback-disable='pactl unload-module module-loopback'
		";
		localBinInPath = true;

	};	
}
