{ pkgs, lib, ... }:

{
  imports = [
    # List your module files here
    ./steam/default.nix
    ./distrobox/default.nix
  ];
}