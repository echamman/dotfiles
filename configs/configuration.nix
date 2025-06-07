{ config, pkgs, pkgs-stable, pkgs-gaming, inputs, outputs, ... }:

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

  boot.kernelPackages = pkgs.linuxPackages_6_14;

  # VirtualBox fix https://github.com/NixOS/nixpkgs/issues/363887#issuecomment-2536693220 
  boot.kernelParams = [ "kvm.enable_virt_at_load=0" ];

  networking.hostName = "enix"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  networking.firewall = {
    enable = true;

    /*allowedTCPPorts = [ 
      #Sunshine
      47984 47989 47990 48010 
    ];*/

    allowedUDPPorts = [ 
      # Bambu 
      1990 2021 
    ];

    /*allowedUDPPortRanges = [
      #Sunshine
      { from = 47998; to = 48000; }
      { from = 8000; to = 8010; }
    ];*/
    
  };

  # Enable networking
  networking.networkmanager.enable = true;
  #networking.nameservers = ["10.0.0.250" "10.0.0.250"];
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
    displayManager.sddm.wayland.enable = true;
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

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Scanner enable
  hardware.sane = {
    enable = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.onedrive.enable = true;

  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  # For Lutris
  systemd.extraConfig = "DefaultLimitNOFILE=524288";
  security.pam.loginLimits = [{
    domain = "ethan";
    type = "hard";
    item = "nofile";
    value = "524288";
  }];
    
  #Add extra udev rules
  services.udev = {
    extraRules = ''
    # Daisy Seed
    SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="df11", MODE="0664", GROUP="wheel"
    #Pi Pico
    SUBSYSTEM=="usb", ATTR{idVendor}=="2e8a", ATTR{idProduct}=="0003", MODE="0664", GROUP="wheel"
    # Elegoo Nano
    SUBSYSTEM=="usb", ATTR{idVendor}=="1a86", ATTR{idProduct}=="7523", MODE="0664", GROUP="wheel"
  '';
    packages = with pkgs; [ 
      utsushi 
      teensy-udev-rules
    ];
  };

  # Musnix Config
  musnix = {
    enable = true;
    kernel.realtime = false;
  };

  users.users.ethan = {
    isNormalUser = true;
    description = "ethan";
    extraGroups = [ "networkmanager" "wheel" "corectrl" "audio" "vboxusers" "scanner" "lp" "dialout"];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable Cachix
  nix.settings = {
    substituters = ["https://nix-gaming.cachix.org"];
    trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
  };

  # Automatic Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Automatic store cleaning
  nix.optimise = {
    automatic = true;
    dates = [ "3:45" ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    NH_FLAKE = "/home/ethan/.dotfiles";
    TERMINAL = "kitty";
  };

  # Support 32bit drivers Mesa
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Tailscale
  services.tailscale.enable = true;

  # Mullvad
  services.mullvad-vpn.enable = true;

  # Virtualisation enable
  virtualisation.virtualbox.host.enable = true;
  
  # System wide ZSH enable
  programs.zsh.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [

    # Wine Packages
    wineWowPackages.stable
    winetricks
    #pkgs-gaming.wine-tkg
    inputs.nix-gaming.packages.${pkgs.system}.wine-tkg

    # gaming
    lutris
    protontricks
    r2modman
    #(callPackage ../packages/r2modman { })
    kdePackages.xwaylandvideobridge

    # System wide utilities
    gparted
    appimage-run
    mullvad-vpn
    dunst
    libnotify
    fuse
    nur.repos.xddxdd.vk-hdr-layer # HDR for Vulkan

    # Nix Utilities
    nh  # Nix Helper
    nix-output-monitor
    nvd
  ];

  # Custom Modules
  steam.enable = true;
  distrobox.enable = true;

  # programs.corectrl = {
  #   enable = true;
  #   gpuOverclock.ppfeaturemask = "0xffffffff";
  #   gpuOverclock.enable = true;
  # };

  programs.kdeconnect.enable = true;

  # 1Password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "ethan" ];
  };
  
  # 1password zen browser
  environment.etc = {
  "1password/custom_allowed_browsers" = {
    text = ''
      .zen
    ''; 
    mode = "0755";
  };
};
  # Hyprland Setup
  programs.hyprland = {
    enable = false;
    xwayland.enable = true;
    #portalPackage = inputs.hyprland-portal.packages."x86_64-linux".xdg-desktop-portal-hyprland;
  };
  programs.dconf.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  #Sunshine game streaming
  services.sunshine = {
    enable = true;
    autoStart = false;
    capSysAdmin = true;
    openFirewall = true;
    
  };

  services = {
    syncthing = {
        enable = true;
        group = "users";
        user = "ethan";
        dataDir = "/home/ethan/Documents";    # Default folder for new synced folders
        configDir = "/home/ethan/Documents/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
};

services.overwitch.enable = true; 

  # Configure fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
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
      nerd-fonts.fira-code
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

  # Do not update
  system.stateVersion = "23.11";

}
