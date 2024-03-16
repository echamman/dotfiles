{config, pkgs, lib, inputs, ... }:

{
  # Add options for Rofi
  options.rofi.enable = lib.mkEnableOption "rofi";

  # Install Rofi
  config = lib.mkIf config.rofi.enable {
    
    programs.rofi = {

      # Enable Rofi
      enable = true;
      package = pkgs.rofi;

    };

    # Configure rofi
    xdg.configFile."rofi/config.rasi".text = builtins.readFile ./config.rasi;
    xdg.configFile."rofi/extra-config.rasi".text = '''';

    # Copy scripts folder
    xdg.configFile."rofi/scripts".source = ./scripts;
  };
}