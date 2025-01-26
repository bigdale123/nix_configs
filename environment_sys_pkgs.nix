# Contains system packages definition and environment definitions
{ config, pkgs, ... }: {
	environment = {
		systemPackages = with pkgs; [
			(pkgs.buildFHSEnv {
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
				future
				cryptography
				pyopenssl
				ndg-httpsclient
				pyasn1
			]))
			cargo
			rustc
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
			mesa
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
			mpv
			vagrant
		];
		interactiveShellInit = "
			alias loopback-enable='pactl load-module module-loopback latency_msec=1'
			alias loopback-disable='pactl unload-module module-loopback'
		";
		localBinInPath = true;
	};	
}
