{ config, pkgs, inputs, ... }:

{
  # Import Home manager modules directory
  imports =
  [ 
    ../homemanagermodules
    inputs.nix-colors.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.default
    #inputs.nixvim.homeManagerModules.nixvim
    inputs.zen-browser.homeModules.beta
  ];

  home.username = "ethan";
  home.homeDirectory = "/home/ethan";

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  colorScheme = inputs.nix-colors.colorSchemes.rose-pine-moon;

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # Terminal
    fastfetch
    #nnn # terminal file manager
    btop  # replacement of htop/nmon
    nvtopPackages.amd
    iotop # io monitoring
    iftop # network monitoring
    htop 
    fzf # Fuzzy Finder
    eza # ls replacement
    bat # cat replacement
    #delta # git diff
    neovim # neovim

    # archives
    zip
    xz
    unzip
    p7zip
    unrar

    # utils
    vlc
    ncdu  # Disk space sniffer
    #swww  # Wallpaper utility
    #grimblast # Screenshot util
    usbutils  # USB drivers and utilities
    wget
    remmina #RDP client
    simple-scan #scan GUI
    dfu-util  # Flash DFU devices over USB
    screen    # Terminal monitor
    assimp    # Asset Importer for games
    gphoto2   # Handles digital camera file transfer
    alsa-scarlett-gui # Focusrite
    moonlight-qt
    syncthing
    mangohud  

    # networking tools
    nmap # A utility for network discovery and security auditing

    # Applications
    qbittorrent
    vscode
    #discord
    vesktop # Discord alt
    telegram-desktop
    thunderbird
    firefox
    element-desktop
    google-chrome  # For work
    kdePackages.kdenlive
    glaxnimate # For KDENLive
    #inputs.old-darktable-nixpkgs.legacyPackages.${system}.darktable
    darktable
    onlyoffice-bin
    #libreoffice-qt6-fresh
    kicad
    pinta     #paint
    inputs.old-orcaslicer-nixpkgs.legacyPackages.${system}.orca-slicer
    #orca-slicer
    obsidian
    boxbuddy  # Manages distroboxes
    
    # Games
    prismlauncher
    dolphin-emu
    clonehero
    minigalaxy

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # Music Production
    bitwig-studio
    reaper
    inputs.nixpkgs-stable.legacyPackages.${system}.yabridge # Use NixPkgs Stable because it breaks often
    yabridgectl
    elektroid

    # KDE Plugins
    (callPackage ../packages/kde-window-title-applet { })
    plasmusic-toolbar
    (callPackage ../packages/kde-wunderground { })
    kara
    kdePackages.wallpaper-engine-plugin
  ];

  # Git config
  programs.git = {
    enable = true;
    userName  = "echamman";
    userEmail = "e.hamman@telus.net";
  };

  programs.zen-browser = {
    enable = true;
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      # find more options here: https://mozilla.github.io/policy-templates/
    };
  };

  starship.enable = true; 
  kitty.enable = true;
  tofi.enable = true;
  zsh.enable = true;
  waybar.enable = true;
  spicetify.enable = true;
  obs-studio.enable = true;
  #neovim.enable = true;

  # The version number that was first installed. DO NOT CHANGE
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
