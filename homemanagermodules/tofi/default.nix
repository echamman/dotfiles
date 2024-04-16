{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.tofi.enable = lib.mkEnableOption "tofi";

  # Install tofi if desired
  config = lib.mkIf config.tofi.enable {

    home.file.".config/tofi/config".source = ./config;

    home.packages = with pkgs; [
      tofi
    ];
  };
}