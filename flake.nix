{
  description = "Ethan's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Old kernel
    old-kernel-nixpkgs.url = "github:nixos/nixpkgs/e89cf1c932006531f454de7d652163a9a5c86668";

    # Older yabridge package
    old-yabridge-nixpkgs.url = "github:nixos/nixpkgs/fd04bea4cbf76f86f244b9e2549fca066db8ddff";

    # For grub theme
    grub2-themes.url = "github:vinceliuice/grub2-themes";

    # Musnix for music
    musnix.url = "github:musnix/musnix";

    # Color customization
    nix-colors.url = "github:misterio77/nix-colors";

    # Spicetify 
    spicetify-nix.url = "github:the-argus/spicetify-nix";

    # Superfile
    superfile.url = "github:MHNightCat/superfile";
    
    # Nixvim 
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, grub2-themes, spicetify-nix, ... }:

    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      #inherit (self) outputs;
      
    in
    {
      nixosConfigurations = {

        enix = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs; };

          modules = [
            ./configs/configuration.nix
            ./modules

            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.ethan = import ./configs/home.nix;
            }

            inputs.home-manager.nixosModules.default
            grub2-themes.nixosModules.default
            inputs.musnix.nixosModules.musnix
          ];
        };
      };
    };
}
