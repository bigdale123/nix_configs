{ config, lib, pkgs, ... }:
let
	home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
	imports = [
		(import "${home-manager}/nixos")
		./i3.nix
		./dunst.nix
		./i3status.nix
		./alacritty.nix
	];
	users.users.dylan = {
		isNormalUser = true;
		description = "Dylan";
		extraGroups = ["networkmanager" "wheel" "plugdev"];
	};
	home-manager.backupFileExtension = "bak";
	home-manager.users.dylan = {
		/* The home.stateVersion option does not have a default and must be set */
		home.stateVersion = "24.05";
		home.packages = with pkgs; [
			firefox
			discord
			moonlight-qt
			seafile-client
			zoom-us
			libreoffice-still
			gimp
			gh
			spotify
			btop
			cava
			prismlauncher
			audacity
			obsidian
			peek
			prusa-slicer
			vlc
			rtl-sdr
			(vscode-with-extensions.override {
				vscodeExtensions = with vscode-extensions; [
					ms-vscode.hexeditor
				] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
					{
						name = "cobol";
						publisher = "bitlang";
						version = "24.10.11";
						sha256 = "5SddLcQ1AQ5IvNQZRmvuSXHTPy922cny6Qz3KXZtF5E=";
					}
					{
						name = "Nix";
						publisher = "bbenoist";
						version = "1.0.1";
						sha256 = "qwxqOGublQeVP2qrLF94ndX/Be9oZOn+ZMCFX1yyoH0=";
					}
				];
			})
			postman
			x3270
			cool-retro-term
		];
		programs.git = {
			enable = true;
			userEmail = "dylcal138@gmail.com";
			userName = "Dylan Calvin";
		};
	};
}

