{ config, pkgs, inputs, outputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      
      outputs.nixosModules.steam
      #outputs.nixosModules.rofi
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
  };

  boot.supportedFilesystems = [ "ntfs" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;
  networking.nameservers = ["10.0.0.250" "10.0.0.250"];
  # Set your time zone.
  time.timeZone = "America/Vancouver";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # DE
  services = {
    xserver.enable = true;
    xserver.videoDrivers = ["amdgpu"];

    # KDE
    xserver.displayManager.sddm.enable = true;
    desktopManager.plasma6.enable = true;

    # i3
    xserver.windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        #dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock-fancy-rapid # i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  };

# Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.flatpak.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  users.users.ethan = {
    isNormalUser = true;
    description = "ethan";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "ethan" = import ./home.nix;
    };
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = false;
  services.xserver.displayManager.autoLogin.user = "ethan";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

# Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable AMD
  # boot.initrd.kernelmodules = [ "amdgpu"];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  # Tailscale
  services.tailscale.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # support both 32- and 64-bit applications
    wineWowPackages.stable
    winetricks
    wineWowPackages.waylandFull

    # gaming
    gamescope
    mangohud
    lutris
    protontricks
    r2modman
    steamtinkerlaunch

    gparted

    # Themes
    gnome.gnome-themes-extra
    gtk-engine-murrine
    gnome.adwaita-icon-theme
    gnome.gnome-tweaks

    # i3
    arandr  # Monitor Config
    feh     # Wallpaper
    picom   # Compositor
  ];

  # Custom Modules
  steam.enable = true;
  #rofi.enable = true;

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
