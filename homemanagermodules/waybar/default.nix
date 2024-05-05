{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.waybar.enable = lib.mkEnableOption "waybar";

  # Install kitty if desired
  config = lib.mkIf config.waybar.enable {

    home.file.".config/waybar/config".source = ./config;
    home.file.".config/waybar/style.css".source = ./style.css;
    home.file.".config/waybar/rose-pine-moon.css".source = ./rose-pine-moon.css;

    home.packages = with pkgs; [
      waybar
      pavucontrol
    ];
  };
}
