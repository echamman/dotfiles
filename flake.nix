{
  description = "Ethan's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    old-yabridge-nixpkgs.url = "github:nixos/nixpkgs/fd04bea4cbf76f86f244b9e2549fca066db8ddff";

    grub2-themes.url = "github:vinceliuice/grub2-themes";

    musnix.url = "github:musnix/musnix";

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
      #inherit (self) outputs;
      
    in
    {
      nixosConfigurations = {

        default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs; };

          modules = [
            ./hosts/default/configuration.nix
            ./modules
            ./homemanagermodules

            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ethan = import ./hosts/default/home.nix;
            }

            inputs.home-manager.nixosModules.default
            grub2-themes.nixosModules.default
            inputs.musnix.nixosModules.musnix
          ];
        };
      };
    };
}
