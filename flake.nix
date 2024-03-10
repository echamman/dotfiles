{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:

    let
      system = "x86_64-linx";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {

        default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};

          modules = [
            ./configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
