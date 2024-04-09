{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.starship.enable = lib.mkEnableOption "starship";

  # Install steam if desired
  config = lib.mkIf config.starship.enable {
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
  };
}