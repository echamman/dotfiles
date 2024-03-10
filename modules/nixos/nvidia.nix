{ config, pkgs, ... }:

{
  description = "Nvidia Configuration"

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"]; # or "nvidiaLegacy470 etc.

  hardware.nvidia = {
    
    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
}