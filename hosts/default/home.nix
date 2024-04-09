{ config, pkgs, inputs, ... }:

{
  home.username = "ethan";
  home.homeDirectory = "/home/ethan";

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

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

    # archives
    zip
    xz
    unzip
    p7zip
    unrar

    # utils
    just
    tofi
    vlc

    # networking tools
    nmap # A utility for network discovery and security auditing

    # Applications
    qbittorrent-qt5
    spotify
    vscode
    discord
    vesktop # Discord alt
    telegram-desktop
    thunderbird
    firefox
    element-desktop

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # Music Production
    bitwig-studio
    reaper
    inputs.old-yabridge-nixpkgs.legacyPackages.${system}.yabridge
    yabridgectl
  ];

  # Git config
  programs.git = {
    enable = true;
    userName  = "echamman";
    userEmail = "e.hamman@telus.net";
  };
  
  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your cusotm bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';
  };

  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
