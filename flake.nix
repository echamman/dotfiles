{
  description = "Ethan's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    grub2-themes.url = "github:vinceliuice/grub2-themes";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, grub2-themes, ... }:

    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      inherit (self) outputs;
    in
    {

      nixosModules = import ./modules;

      nixosConfigurations = {

        default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs outputs;};

          modules = [
            ./hosts/default/configuration.nix
            inputs.home-manager.nixosModules.default
            grub2-themes.nixosModules.default
          ];
        };
      };
    };
}
