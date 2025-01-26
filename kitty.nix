{ config, lib, pkgs, ... }:
{
	home-manager.users.dylan = {
		programs.kitty = {
			enable = true;
			settings = {
				confirm_os_window_close = 0;
				cursor_blink_interval = "0.5 ease-in-out";
				background_opacity = .75;
			};
		};		
	};
}
