{ config, lib, pkgs, ...}:

{
	home-manager.users.dylan = {
		services.dunst = {
                        enable = true;
                        settings = {
                                global = {
                                        follow = "mouse";
                                        width = 300;
                                        height = 300;
                                        origin = "top-right";
                                        offset = "10x50";
                                        scale = 0;
                                        transparency = 10;
                                        notification_limit = 20;
                                        font = "hack 9";
                                        indicate_hidden = "yes";
                                        separator_height = 2;
                                        padding = 8;
					browser = "${pkgs.xdg-utils}/bin/xdg-open";
					corner_radius = 8;
					markup = "full";
					# Theming colors gotten from catpuccin dunst theme
					frame_color = "#8aadf4";
					separator_color = "frame";
                                };
				urgency_low = {
					background = "#24273a";
					foreground = "#cad3f5";
				};
				urgency_normal = {
                                        background = "#24273a";
					foreground = "#cad3f5";
                                };
				urgency_critical = {
                                        background = "#24273a";
					foreground = "#cad3f5";
					frame_color = "#f5a97f";
                                };
                        };
                };
	};
}
