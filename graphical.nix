# Contains all options relating to graphics, Desktop Environment, and all additional
# packages related to these.

{ config, pkgs, ... }: {
	services.xserver = {
		enable = true;
		desktopManager = {
			xterm.enable = false;
			xfce = {
				enable = true;
				noDesktop = true;
				enableXfwm = false;
				enableScreensaver = true;
			};
		};
		videoDrivers = [ "amdgpu" ];
		deviceSection = ''Option "TearFree" "true"'';
		displayManager.gdm.enable = true;
		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				rofi
				i3status
				i3lock
				feh
				alacritty
				xarchiver
				blueman
				dunst
				picom
				neofetch
				jp2a
				lxappearance
				xkb-switch
			];
		};
		xkb = {
			layout = "us";
			variant = "";
		};
	};
	services.displayManager.defaultSession = "xfce+i3";
	services.picom.enable = true;

	environment.xfce.excludePackages = with pkgs.xfce; [
		xfce4-notifyd
	];

	programs.thunar.plugins = with pkgs.xfce; [
		thunar-archive-plugin
		thunar-volman
	];
}
