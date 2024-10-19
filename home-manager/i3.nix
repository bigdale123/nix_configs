{ config, lib, pkgs, ... }:

{
	home-manager.users.dylan = {
		xsession.windowManager.i3 =
		let
			bgcolor = "#00ff8333";
                        inactive-bgcolor = "#1854294d";
                        active-bgcolor = "#00cc694d";
                        text = "#6b54a6";
                        u-bgcolor = "#ffc603";
                        indicator = "#99ffcd";
                        inactive-text = "#403264";
		in {
			enable = true;
			package = pkgs.i3;
			config = {
				modifier = "Mod4";
				startup = [
					{
						command = "nm-applet";
						always = false;
					}
					{
						command = "picom";
						always = true;
					}
					{
						command = "dunst -config ~/.config/dunst/dunstrc";
						always = true;
					}
					{
						command = "discord";
						always = false;
					}
					{
						command = "seafile-applet";
						always = false;
					}
					{
						command = "feh --bg-scale /etc/nixos/wallpapers/triop.png";
						always = true;
					}
				];
				gaps = {
					inner = 5;
				};
				bars = [
					{	
						fonts = {
                                        		names = ["hack"];
                                        		size = 9.0;
                        			};
						position = "top";
						command = "${pkgs.i3}/bin/i3bar -t";
						statusCommand = "i3status";
						colors = {
							background = "${bgcolor}";
							separator = "${text}";
							focusedWorkspace = {
								background = "${bgcolor}";
								border = "${bgcolor}";
								text = "${text}";
							};
							activeWorkspace = {
								background = "${active-bgcolor}";
                                                                border = "${active-bgcolor}";
                                                                text = "${text}";
							};
							inactiveWorkspace = {
								background = "${inactive-bgcolor}";
                                                                border = "${inactive-bgcolor}";
                                                                text = "${text}";
							};
							urgentWorkspace = {
								background = "${u-bgcolor}";
                                                                border = "${u-bgcolor}";
                                                                text = "${text}";
							};
						};
						
					}
				];
				colors = {
					focused = {
						background = "${bgcolor}";
						border = "${bgcolor}";
						indicator = "${indicator}";
						text = "${text}";
						childBorder = "${bgcolor}";
					};
					unfocused = {
						background = "${inactive-bgcolor}";
						border = "${inactive-bgcolor}";
						indicator = "${inactive-bgcolor}";
						text = "${inactive-text}";
						childBorder = "${inactive-bgcolor}";
					};
					focusedInactive = {
						background = "${inactive-bgcolor}";
						border = "${inactive-bgcolor}";
						indicator = "${inactive-bgcolor}";
						text = "${inactive-text}";
						childBorder = "${inactive-bgcolor}";
					};
					urgent = {
						background = "${u-bgcolor}";
						border = "${u-bgcolor}";
						indicator = "${u-bgcolor}";
						text = "${text}";
						childBorder = "${u-bgcolor}";
					};
				};
				fonts = {
					names = ["hack"];
					size = 9.0;
				};
				terminal = "alacritty";
				window = {
					border = 1;
					titlebar = false;
				};
				menu = "--no-startup-id \"rofi -modi 'drun,run' -show drun\"";
				keybindings = let modifier = "Mod4"; in lib.mkOptionDefault {
					"${modifier}+Shift+e" = "exec --no-startup-id xfce4-session-logout";
					"${modifier}+Shift+s" = "exec --no-startup-id maim -s -u | tee ~/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png | xclip -selection clipboard -t image/png";
					"${modifier}+Ctrl+Shift+h" = "exec \"setxkbmap -layout us,il -variant ,biblical && xkb-switch -s 'il(biblical)' && notify-send 'Hebrew Mode'\"";
					"${modifier}+Ctrl+Shift+u" = "exec \"setxkbmap -layout us,il -variant ,biblical && xkb-switch -s us && notify-send 'America Mode'\"";
					"${modifier}+Ctrl+Shift+period" = "move workspace to output right";
					"${modifier}+Ctrl+Shift+comma" = "move workspace to output left";
				};
			};
		};
	};
}
