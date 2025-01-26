{ config, lib, pkgs, ... }:
{
    users.users.dylan = {
		isNormalUser = true;
		description = "Dylan";
		extraGroups = ["networkmanager" "wheel" "plugdev" "vboxusers"];
	};
	
	
	home-manager.users.dylan = {
		/* The home.stateVersion option does not have a default and must be set */
		home.stateVersion = "24.05";
		home.packages = with pkgs; [
			firefox
			google-chrome
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
			anki-bin
			inkscape
			scribus
			revanced-cli
			qsynth
			neothesia
			musescore
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
			cool-retro-term
			cbonsai
		];
		programs.git = {
			enable = true;
			userEmail = "dylcal138@gmail.com";
			userName = "Dylan Calvin";
		};
		programs.neovim = {
			enable = true;
		    	viAlias = true;
			vimAlias = true;		
			vimdiffAlias = true;
			plugins = with pkgs.vimPlugins; [
				
			];
			extraConfig = ''
				set number relativenumber
				highlight Normal ctermbg=NONE guibg=NONE
			'';
		};
	};
}
