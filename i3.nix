# Contains all options relating to graphics, Desktop Environment, and all additional
# packages related to these.

{ config, lib, pkgs, ... }: {
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
		displayManager.gdm.enable = true;
		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				rofi
				i3status
				i3lock
				feh
				kitty
				xarchiver
				blueman
				dunst
				picom
				discord
				neofetch
				jp2a
				lxappearance
				xkb-switch
				pavucontrol
			];
		};
		xkb = {
			layout = "us";
			variant = "";
		};
	};
	services.displayManager.defaultSession = "xfce+i3";
	services.picom.enable = true;

	hardware.pulseaudio = {
		enable = true;
		support32Bit = true;
	};

	environment.xfce.excludePackages = with pkgs.xfce; [
		xfce4-notifyd
	];

	programs.thunar.plugins = with pkgs.xfce; [
		thunar-archive-plugin
		thunar-volman
	];

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
								background = "${inactive-bgcolor}";
								border = "${inactive-bgcolor}";
								text = "${text}";
							};
							activeWorkspace = {
								background = "${inactive-bgcolor}";
                                                                border = "${inactive-bgcolor}";
                                                                text = "${text}";
							};
							inactiveWorkspace = {
								background = "${bgcolor}";
                                                                border = "${bgcolor}";
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
				terminal = "WINIT_X11_SCALE_FACTOR=1.5 kitty";
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
		programs.i3status = {
			enable = true;
			modules = {
				"wireless _first_" = {
                                        enable = true;
                                        position = 0;
                                        settings = {
						format_up = "W: (%quality at %essid) %ip";
						format_down = "W: down";
                                        };
                                };
				"ethernet _first_" = {
                                        enable = true;
                                        position = 1;
                                        settings = {
						format_up = "E: %ip (%speed)";
						format_down = "E: down";
                                        };
                                };
				"volume master" = {
                                        enable = true;
                                        position = 2;
                                        settings = {
						format = "♪: %volume";
						format_muted = "♪: muted (%volume)";
						device = "default";
                                        };
                                };
                                "battery all" = {
                                        enable = true;
                                        position = 3;
                                        settings = {
						format = "%status %percentage %remaining";
						last_full_capacity = true;
					};
				};
				"disk /" = {
                                        enable = true;
                                        position = 4;
                                        settings = {
                                                format = "%avail";
                                        };
                                };
				"load" = {
                                        enable = true;
                                        position = 5;
                                        settings = {
                                                format = "%1min";
                                        };
                                };
				"cpu_usage" = {
					enable = true;
					position = 6;
					settings = {
						format = "%usage";
						format_above_threshold = "HIGH CPU";
					};
				};
				"memory" = {
					enable = true;
					position = 7;
					settings = {
						format = "%available";
						threshold_degraded = "1G";
						format_degraded = "MEM LOW";
					};
				};
				"tztime local" = {
					enable = true;
					position = 8;
					settings = {
						format = "%m-%d-%Y %H:%M:%S";
					};
				};
			};
		};
	};
}
