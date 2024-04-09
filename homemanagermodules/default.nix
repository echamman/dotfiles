{ pkgs, lib, ... }:

{
  imports = [
    # List your module files here
    ./starship/default.nix
  ];
}