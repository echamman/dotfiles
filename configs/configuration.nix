{ config, pkgs, inputs, outputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      devices = [ "nodev" ];
      efiSupport = true;
      useOSProber = true;
    };

    grub2-theme = {
      enable = true;
      theme = "vimix";
      icon = "color";
      screen = "ultrawide2k";
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = ["10.0.0.250" "10.0.0.250"];
  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Bluetooth enable
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # DE
  services = {
    xserver.enable = true;
    xserver.videoDrivers = ["amdgpu"];

    # KDE
    displayManager.sddm.enable = true;
    #displayManager.sddm.theme = "rose-pine";
    desktopManager.plasma6.enable = true;
    displayManager.autoLogin.enable = false;

  };

# Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.flatpak.enable = true;

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint pkgs.cnijfilter2 ];
  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Musnix Config
  musnix = {
    enable = true;
    kernel.realtime = false;
  };

  users.users.ethan = {
    isNormalUser = true;
    description = "ethan";
    extraGroups = [ "networkmanager" "wheel" "corectrl" "audio" "vboxusers"];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Tailscale
  services.tailscale.enable = true;

  # Virtualisation enable
  virtualisation.virtualbox.host.enable = true;
  
  # System wide ZSH enable
  programs.zsh.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [

    # Wine Packages
    wineWowPackages.stable
    #wine64
    winetricks
    #wineWowPackages.waylandFull

    # gaming
    gamescope
    mangohud
    lutris
    protontricks
    r2modman
    steamtinkerlaunch
    xwaylandvideobridge

    # System wide utilities
    gparted
    appimage-run

  ];

  # Custom Modules
  steam.enable = true;

  programs.corectrl = {
    enable = true;
    gpuOverclock.ppfeaturemask = "0xffffffff";
    gpuOverclock.enable = true;
  };

  programs.kdeconnect.enable = true;

  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "ethan" ];
  };

  # Configure fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      source-han-mono
      source-han-code-jp
      twitter-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      dina-font
      ubuntu_font_family
      open-sans
      # nerdfonts
      (nerdfonts.override { fonts = [ "FiraCode" ]; })
    ];

    # Enable default fonts
    enableDefaultPackages = true;

    # Configure default fonts
    fontconfig = {
      defaultFonts = {
        serif = [ "Ubuntu" "Regular" ];
        sansSerif = [ "Ubuntu" "Regular" ];
        monospace = [ "FiraCode Nerd Font" "Regular" ];
      };
    };
  };

  system.stateVersion = "23.11"; # Did you read the comment?

}
