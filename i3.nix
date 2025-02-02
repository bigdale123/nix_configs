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
				enableScreensaver = false;
			};
		};
		videoDrivers = [ "mesa" ];
		displayManager.lightdm = {
			enable = true;
			background = "/etc/nixos/wallpapers/tv_severance_lumon.png";
			greeter.enable = true;
			greeters.slick = {
				enable = true;
			};
		};
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
				discord
				jp2a
				lxappearance
				xkb-switch
				picom
				pavucontrol
				xcolor
			];
		};
		xkb = {
			layout = "us";
			variant = "";
		};
	};
	services.displayManager.defaultSession = "xfce+i3";

	services.pulseaudio = {
		enable = true;
		support32Bit = true;
	};
	services.pipewire.enable = false;

	environment.xfce.excludePackages = with pkgs.xfce; [
		xfce4-notifyd
		xfce4-volumed-pulse # So that i3 can handle it, allowing for customization
		xfce4-pulseaudio-plugin # ditto the above
	];

	programs.thunar.plugins = with pkgs.xfce; [
		thunar-archive-plugin
		thunar-volman
	];

	home-manager.users.dylan = {
		xsession.windowManager.i3 =
		let
			wallpaper = "/etc/nixos/wallpapers/tv_severance_lumon.png";
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
						command = "feh --bg-scale ${wallpaper}";
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
							background = "#0f151d";
							statusline = "#dee9ee";
							separator = "#dee9ee";
							focusedWorkspace = {
								border = "#93acc3";
								background = "#024d81";
								text = "#dee9ee";
							};
							activeWorkspace = {  
                                                                border = "#2f343a";
                                                                background = "#1d2735";
                                                                text = "#dee9ee";
                                                        };
							inactiveWorkspace = {  
                                                                border = "#2f343a";
                                                                background = "#1d2735";
                                                                text = "#56769f";
                                                        };
							urgentWorkspace = {  
                                                                border = "#2f343a";
                                                                background = "#db504a";
                                                                text = "#dee9ee";
                                                        };
							bindingMode = {  
                                                                border = "#2f343a";
                                                                background = "#db504a";
                                                                text = "#dee9ee";
                                                        };
						};
					}
				];
				colors = {
					focused = {
						border = "#93acc3";
						background = "#024d81";
						text = "#dee9ee";
						indicator = "#F9B9F2";
						childBorder = "#024d81";
					};
					focusedInactive = {  
                                                border = "#10161e";
                                                background = "#93acc3";
                                                text = "#10161e";
                                                indicator = "#F9B9F2";
                                                childBorder = "#93acc3";
                                        };
					unfocused = {  
                                                border = "#333333";
                                                background = "#222222";
                                                text = "#56769f";
                                                indicator = "#F9B9F2";
                                                childBorder = "#222222";
                                        };
					urgent = {  
                                                border = "#2f344a";
                                                background = "#db504a";
                                                text = "#dee9ee";
                                                indicator = "#F9B9F2";
                                                childBorder = "#db504a";
                                        };
					placeholder = {  
                                                border = "#0e141b";
                                                background = "#oe141b";
                                                text = "#dee9ee";
                                                indicator = "#F9B9F2";
                                                childBorder = "#oe141b";
                                        };
					background = "#dee9ee";
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
					"${modifier}+Ctrl+Shift+Right" = "move workspace to output right";
					"${modifier}+Ctrl+Shift+Left" = "move workspace to output left";
					"XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +1%";
					"XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -1%";
					"XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";
					"${modifier}+Shift+c" = "exec xcolor -s";
				};
			};
		};
		programs.i3status = {
			enable = true;
			general = {
				colors = true;
				color_good = "#dee9ee";
				color_degraded = "#e3b505";
				color_bad = "#db504a";
				interval = 1;
			};
			modules = {
				"ipv6" = {
					enable = false;
				};	
				"wireless _first_" = {
                                        enable = false;
                                        position = 0;
                                        settings = {
						format_up = "W: (%quality at %essid) %ip";
						format_down = "W: down";
                                        };
                                };
				"ethernet _first_" = {
                                        enable = false;
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
                                        enable = false;
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
					enable = false;
					position = 6;
					settings = {
						format = "%usage";
						format_above_threshold = "HIGH CPU";
					};
				};
				"memory" = {
					enable = false;
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
		services.picom.enable = true;
		services.picom.opacityRules = [
			"100:window_type = 'tooltip'"
		];
	};
}
