{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.starship.enable = lib.mkEnableOption "starship";

  # Install starship if desired
  config = lib.mkIf config.starship.enable {

    home.file.".config/starship.toml".source = ./starship.toml;

    # starship - an customizable prompt for any shell
    programs.starship = {
      enable = true;
      # custom settings
      #settings = {
       # color_fg0 = "#${config.colorScheme.colors.base00}";
      #};
    };
  };
}