{ config, pkgs, lib, inputs, ... }:

{
  # Add enable 
  options.obs-studio.enable = lib.mkEnableOption "obs-studio";

  # Install obs-studio if desired
  config = lib.mkIf config.obs-studio.enable {

    # obs-studio - an customizable prompt for any shell
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        yuobs-vkcapture
      ];
    };
  };
}