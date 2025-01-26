{ config, lib, pkgs, ... }:
{
	home-manager.users.dylan = {
		programs.alacritty = {
			enable = true;
			settings = {
				window.opacity = 0.8;
				font.size = 8;
			};
		};
	};
}
