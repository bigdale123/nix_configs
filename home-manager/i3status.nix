{ config, lib, pkgs, ... }:
{
	home-manager.users.dylan = {
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
