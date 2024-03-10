{ config, pkgs, lib, inputs, ... }:

{
  # Add options for Steam
  options.steam.enable = lib.mkEnableOption "steam";

  # Install steam if desired
  config = lib.mkIf config.steam.enable {

    # Allow Steam controllers and other steam hardware
    hardware.steam-hardware.enable = true;

    # Configure Steam
    programs.steam = {

      # Enable steam
      enable = true;

      # Open firewall for remote play
      remotePlay.openFirewall = true;

      # Open firewall for Source Dedicated Server
      dedicatedServer.openFirewall = true;
    };
  };
}