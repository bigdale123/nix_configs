# Contains all options relating to graphics, Desktop Environment, and all additional
# packages related to these.

{ config, lib, pkgs, ... }: {
	# enable hyprland
	programs.hyprland.enable = true;
	programs.hyprland.xwayland.enable = true;

	# extra packages for hyprland
	environment = {
		systemPackages = with pkgs; [
			dunst
			waybar
			wofi
			wlogout
			kitty
			hyprpicker
			hyprpaper
			hyprcursor
			xfce.thunar
			wdisplays
			wl-clipboard
			grim
			slurp
			xwaylandvideobridge
			vesktop
			networkmanagerapplet
			glib
			wireplumber
		];
	};
	programs.thunar.plugins = with pkgs.xfce; [
		thunar-archive-plugin
		thunar-volman
	];

	# Enable gdm
	services.xserver.displayManager.gdm = {
		enable = true;
		wayland = true;
	};
	# enable pipewire
	services.pipewire = {
        	enable = true;
        	alsa.enable = true;
       		alsa.support32Bit = true;
        	pulse.enable = true;
        };

	# Ozone support for electron and chromium apps
	environment.sessionVariables.NIXOS_OZONE_WL = "1";
	

	# home-manager configs for hyprland
	home-manager.users.dylan = {
		wayland.windowManager.hyprland.enable = true;
		wayland.windowManager.hyprland.plugins = [ pkgs.hyprlandPlugins.hy3 ];
		wayland.windowManager.hyprland.settings = {
			"$terminal" = "kitty";
			"$fileManager" = "thunar";
			"$menu" = "wofi --show drun";
			"$mod" = "SUPER";
			
			source = "/home/dylan/.config/hypr/monitors.conf";
			
			general = {
				layout = "hy3";
			};
		
			"exec-once" = [
				"waybar"
				"nm-applet"
				"dunst -config ~/.config/dunst/dunstrc"
				"vesktop"
				"seafile-applet"
				"hyprpaper"
			];
			bindm = [
				"$mod, mouse:272, hy3:movewindow"
				"$mod, mouse:273, resizewindow"
			];
			bind = [
				# Basic Stuff
				## Should be default
				"$mod, return, exec, $terminal"
				"$mod, D, exec, $menu"
				"$mod_SHIFT, R, exec, hyprctl reload && killall waybar && waybar"
				"$mod_SHIFT, E, exec, wlogout"
				"$mod_SHIFT, Q, hy3:killactive"
				"$mod, F, fullscreen"
				"$mod, SPACE, togglefloating"
				## System binds (Volume, Brightness)
				",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"
				",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
				",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
				## User Binds
				"$mod, s, hy3:changegroup, toggletab"
				"$mod_SHIFT, s, exec, grim -g \"$(slurp)\" - | wl-copy"
				"$mod_CTRL_SHIFT, h, exec, setxkbmap -layout us,il -variant ,biblical && xkb-switch -s 'il(biblical)' && notify-send 'Hebrew Mode'"
				"$mod_CTRL_SHIFT, u, exec, setxkbmap -layout us,il -variant ,biblical && xkb-switch -s us && notify-send 'America Mode'"
				# Navigation
				## Change Focus
				"$mod, LEFT, hy3:movefocus, l"
				"$mod, RIGHT, hy3:movefocus, r"
				"$mod, UP, hy3:movefocus, u"
				"$mod, DOWN, hy3:movefocus, d"
				## Move Windows
				"$mod_SHIFT, LEFT, hy3:movewindow, l"
                                "$mod_SHIFT, RIGHT, hy3:movewindow, r"
                                "$mod_SHIFT, UP, hy3:movewindow, u"
                                "$mod_SHIFT, DOWN, hy3:movewindow, d"	
				# Workspaces
				## Switching to Workspaces
				"$mod, 1, workspace, 1"
				"$mod, 2, workspace, 2"
				"$mod, 3, workspace, 3"
				"$mod, 4, workspace, 4"
				"$mod, 5, workspace, 5"
                                "$mod, 6, workspace, 6"
                                "$mod, 7, workspace, 7"
                                "$mod, 8, workspace, 8"
				"$mod, 9, workspace, 9"
                                "$mod, 0, workspace, 10"
				## Moving Windows to Workspaces
				"$mod_SHIFT, 1, hy3:movetoworkspace, 1"
                                "$mod_SHIFT, 2, hy3:movetoworkspace, 2"
                                "$mod_SHIFT, 3, hy3:movetoworkspace, 3"
                                "$mod_SHIFT, 4, hy3:movetoworkspace, 4"
                                "$mod_SHIFT, 5, hy3:movetoworkspace, 5"
                                "$mod_SHIFT, 6, hy3:movetoworkspace, 6"
                                "$mod_SHIFT, 7, hy3:movetoworkspace, 7"
                                "$mod_SHIFT, 8, hy3:movetoworkspace, 8"
                                "$mod_SHIFT, 9, hy3:movetoworkspace, 9"
                                "$mod_SHIFT, 0, hy3:movetoworkspace, 10"
				## Moving Workspaces
				"$mod_CTRL_SHIFT, LEFT, movecurrentworkspacetomonitor, l"
				"$mod_CTRL_SHIFT, RIGHT, movecurrentworkspacetomonitor, r"
			];
			windowrulev2 = [
				"opacity 0.0 override, class:^(xwaylandvideobridge)$"
				"noanim, class:^(xwaylandvideobridge)$"
				"noinitialfocus, class:^(xwaylandvideobridge)$"
				"maxsize 1 1, class:^(xwaylandvideobridge)$"
				"noblur, class:^(xwaylandvideobridge)$"
				"nofocus, class:^(xwaylandvideobridge)$"
			];
		};
		programs.waybar = let
			height = 15;
		in {
			enable = true;
			settings = {
				mainBar = {
					height = height;
					layer = "top";
					position = "top";
					modules-left = ["hyprland/workspaces"];
					modules-center = ["clock"];
					modules-right = ["wireplumber" "tray"];

					tray = {
						icon-size = 15;
					};
				};
			};
		};
		services.hyprpaper.enable = true;
		services.hyprpaper.settings = {
			splash = false;
			splash_offset = 2.0;
			preload = "/etc/nixos/wallpapers/tv_severance_lumon.png";
			wallpaper = " , /etc/nixos/wallpapers/tv_severance_lumon.png";
		};
		gtk = {
			enable = true;
			theme = {
				name = "Yaru";
				package = pkgs.yaru-theme;
			};
			gtk3.extraConfig = {
      				gtk-application-prefer-dark-theme = true;
			};			
			gtk4.extraConfig = {
				gtk-application-prefer-dark-theme = true;
			};
		};
	};
}
