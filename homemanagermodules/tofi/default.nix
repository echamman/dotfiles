{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.tofi.enable = lib.mkEnableOption "tofi";

  # Install starship if desired
  config = lib.mkIf config.tofi.enable {

    home.file.".config/tofi/config".source = ./config;

    # starship - an customizable prompt for any shell
    home.packages = with pkgs; [
      tofi
    ];
  };
}