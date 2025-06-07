{ config, pkgs, lib, inputs, ... }:

{
 # Add options for Distrobox
  options.distrobox.enable = lib.mkEnableOption "distrobox";

  # Install Distrobox
  config = lib.mkIf config.steam.enable {

    virtualisation.podman.enable = true;

    # Distrobox fix https://discourse.nixos.org/t/distrobox-selinux-oci-permission-error/64943/15
    security.lsm = lib.mkForce [ ];
  
    environment.systemPackages = with pkgs; [
      distrobox
    ];
  };
}