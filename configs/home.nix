{ config, pkgs, inputs, ... }:

{
  # Import Home manager modules directory
  imports =
  [ 
    ../homemanagermodules
    inputs.nix-colors.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
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
    nnn # terminal file manager
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
    inputs.superfile.packages.${system}.default

    # archives
    zip
    xz
    unzip
    p7zip
    unrar

    # utils
    vlc
    ncdu  # Disk space sniffer
    swww  # Wallpaper utility
    grimblast # Screenshot util
    usbutils
    wget
    #easyeffects
    mission-center
    remmina #RDP client

    # networking tools
    nmap # A utility for network discovery and security auditing

    # Applications
    qbittorrent-qt5
    vscode
    discord
    vesktop # Discord alt
    telegram-desktop
    thunderbird
    firefox
    element-desktop
    google-chrome  # For work
    kdePackages.kdenlive
    glaxnimate # For KDENLive
    darktable
    
    # Games
    prismlauncher
    dolphin-emu

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # Music Production
    bitwig-studio
    reaper
    inputs.old-yabridge-nixpkgs.legacyPackages.${system}.yabridge
    #yabridge
    yabridgectl

    # KDE Plugins
    (callPackage ../packages/kde-ginti { })
    (callPackage ../packages/kde-window-title-applet { })
    (callPackage ../packages/kde-plasmusic-toolbar { })
    (callPackage ../packages/kde-wunderground { })
  ];

  # Git config
  programs.git = {
    enable = true;
    userName  = "echamman";
    userEmail = "e.hamman@telus.net";
  };

  starship.enable = true; 
  kitty.enable = true;
  tofi.enable = true;
  zsh.enable = true;
  waybar.enable = true;
  spicetify.enable = true;
  #neovim.enable = true;

  # The version number that was first installed. DO NOT CHANGE
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
