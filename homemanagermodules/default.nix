{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    # List your module files here
    ./starship/default.nix
    ./kitty/default.nix
    ./tofi/default.nix
  ];
}