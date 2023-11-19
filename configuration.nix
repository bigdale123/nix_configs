# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
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
    displayManager.gdm.enable = true;
    displayManager.defaultSession = "xfce+i3";
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        rofi
        i3status
        feh
        alacritty
	xarchiver
        blueman
        dunst
      ];
    };
    
    layout = "us";
    xkbVariant = "";
  };

  environment.xfce.excludePackages = with pkgs.xfce; [
    xfce4-notifyd
  ];

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dylan = {
    isNormalUser = true;
    description = "Dylan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      discord
      obsidian
      moonlight-qt
      seafile-client
      zoom-us
      openconnect
      libreoffice-still
      gimp
      gh
      (vscode-with-extensions.override {
         vscodeExtensions = with vscode-extensions; [
           ms-vscode-remote.remote-ssh
           ms-vscode.cmake-tools
         ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
           {
             name = "language-gas-x86";
             publisher = "basdp";
             version = "0.0.2";
             sha256 = "3db5e13aca11d3fe705ee16bcf009c6ae335b8681f4284914e3d203d5559e0a8";
           }
           {
             name = "sqlite-viewer";
             publisher = "qwtel";
             version = "0.3.13";
             sha256 = "e47cb9305a13b93130c2c612b3aa036e8b3ad423c23588218e527e9cfaa44cab";
           }
         ];
      })
      spotifyd
      spotify-tui
      spotify
      btop
      cava
      prismlauncher
      audacity
      john
    #  thunderbird
    ];
  };
 
  fonts.packages = with pkgs; [
     nerdfonts
  ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget
     curl
     ocs-url
     wireguard-tools
     tesseract
     imagemagick
     xsel
     maim
     xclip
     pavucontrol
     mesa
     pulseaudio
     git
     lxappearance
     (python3.withPackages(ps: with ps; [
        flask
        sqlite
        flask-cors
        flask-wtf
     ]))
     libnotify
     gnumake
     gcc
     gdb
     zip
     gzip
     unzip
     gnutar     
     qpdf
     killall
     eigen
     cmake
     bison
     flex
     doxygen
  ];

  environment.interactiveShellInit = "
     alias loopback-enable='pactl load-module module-loopback latency_msec=1'
     alias loopback-disable='pactl unload-module module-loopback'
  ";
  environment.localBinInPath = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
