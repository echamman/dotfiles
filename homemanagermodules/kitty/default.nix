{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.kitty.enable = lib.mkEnableOption "kitty";

  # Install kitty if desired
  config = lib.mkIf config.kitty.enable {

    home.file.".config/kitty/kitty.conf".source = ./kitty.conf;
    home.file.".config/kitty/theme.conf".source = ./theme.conf;

    # kitty 
    home.packages = with pkgs; [
      kitty
    ];
  };
}