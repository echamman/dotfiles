{ config, pkgs, lib, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{

   # Add enable 
  options.spicetify.enable = lib.mkEnableOption "spicetify";

  # Install spicetify if desired
  config = lib.mkIf config.spicetify.enable {

    # import the flake's module for your system
    #imports = [ spicetify-nix.homeManagerModule ];

    # configure spicetify :)
    programs.spicetify =
      {
        enable = true;
        theme = spicePkgs.themes.text;
        colorScheme = "RosePineMoon";

        enabledExtensions = with spicePkgs.extensions; [
          fullAppDisplay
          shuffle # shuffle+ (special characters are sanitized out of ext names)
          hidePodcasts
        ];
      };
  };
}