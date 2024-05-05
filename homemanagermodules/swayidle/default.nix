{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.swayidle.enable = lib.mkEnableOption "swayidle";

  # Install kitty if desired
  config = lib.mkIf config.waybar.enable {

    home.file.".config/swayidle/config".source = ./config;

    home.packages = with pkgs; [
      swayidle
    ];
  };
}
