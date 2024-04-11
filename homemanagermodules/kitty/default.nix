{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.kitty.enable = lib.mkEnableOption "kitty";

  # Install starship if desired
  config = lib.mkIf config.kitty.enable {

    home.file.".config/kitty/kitty.conf".source = ./kitty.conf;
    home.file.".config/kitty/theme.conf".source = ./theme.conf;

    # starship - an customizable prompt for any shell
    home.packages = with pkgs; [
      kitty
    ];
  };
}