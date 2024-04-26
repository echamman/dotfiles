{ config, pkgs, inputs, ... }:

{
  # Import Home manager modules directory
  imports =
  [ 
    ../homemanagermodules
    inputs.nix-colors.homeManagerModules.default
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  home.username = "ethan";
  home.homeDirectory = "/home/ethan";

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  colorScheme = inputs.nix-colors.colorSchemes.rose-pine-moon;

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # Terminal
    neofetch
    nnn # terminal file manager
    btop  # replacement of htop/nmon
    nvtopPackages.amd
    iotop # io monitoring
    iftop # network monitoring
    htop 
    fzf
    eza
    bat
    delta
    neovim

    # archives
    zip
    xz
    unzip
    p7zip
    unrar

    # utils
    rofi-wayland
    vlc
    # caffeine-ng
    ncdu
    waybar
    swww

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
    
    # Games
    prismlauncher

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # Music Production
    bitwig-studio
    reaper
    inputs.old-yabridge-nixpkgs.legacyPackages.${system}.yabridge
    yabridgectl
    (callPackage ../packages/kde-ginti { })
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
  hyprland.enable = true;
  spicetify.enable = true;

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
