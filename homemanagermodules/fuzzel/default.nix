{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.fuzzel.enable = lib.mkEnableOption "fuzzel";

  # Install fuzzel if desired
  config = lib.mkIf config.fuzzel.enable {

    home.file.".config/fuzzel/fuzzel.ini".source = ./fuzzel.ini;

    home.packages = with pkgs; [
      fuzzel
    ];
  };
}