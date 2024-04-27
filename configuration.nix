# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let unstableTarball = fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixpkgs.config = {
     allowUnfree = true;
     packageOverrides = pkgs: {
        unstable = import unstableTarball {
            config = config.nixpkgs.config;
          };
      };
  };

  # Disable all forms of hibernation
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "modprobe.blacklist=dvb_usb_rtl28xxu" ]; # blacklist this module

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.interfaces.enp5s0.useDHCP = false;
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
        i3lock
        feh
        unstable.alacritty
        xarchiver
        blueman
        dunst
        picom
        neofetch
        jp2a
        lxappearance
      ];
    };
    
    layout = "us";
    xkbVariant = "";
  };
  services.picom.enable = true;

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
  hardware.rtl-sdr.enable = true;
  services.blueman.enable = true;
  security.rtkit.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
 
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dylan = {
    isNormalUser = true;
    description = "Dylan";
    extraGroups = [ "networkmanager" "wheel" "plugdev"];
    packages = with pkgs; [
      firefox
      unstable.discord
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
      unstable.obsidian
      peek
      prusa-slicer
      vlc
      rtl-sdr
      sdrpp
      sdrangel
    ];
  };
 
  fonts.packages = with pkgs; [
     nerdfonts
  ];
  
  

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     (pkgs.buildFHSUserEnv {
        name = "devenv";
        profile = ''
           PS1="[\[\033[36m\]devenv\[\033[m\]] \w \$ "
        '';
        targetPkgs = pkgs: with pkgs; [
           (python3.withPackages(ps: with ps; [
              flask
              sqlite
              flask-cors
              flask-wtf
           ]))
           gnumake
           gcc
           gdb
           zulu
        ];
      }
     )
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
     libnotify
     usbutils
     zip
     gzip
     unzip
     gnutar
     qpdf
     killall
     neovim
     zulu
     winetricks
     wineWowPackages.staging
  ];

  environment.interactiveShellInit = "
     alias loopback-enable='pactl load-module module-loopback latency_msec=1'
     alias loopback-disable='pactl unload-module module-loopback'
     alias nixconfig='sudo nvim /etc/nixos/configuration.nix'
     alias nixrebuild='sudo nixos-rebuild switch'
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
  system.stateVersion = "unstable"; # Did you read the comment?

}
