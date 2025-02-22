{
  description = "Ethan's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixpkgs-24.11-darwin";

    # Older orca slicer package
    old-orcaslicer-nixpkgs.url = "github:nixos/nixpkgs/aa1203429f56d2e816a77fda34f069705e975f97";
    
    # For grub theme
    grub2-themes.url = "github:vinceliuice/grub2-themes";

    # Musnix for music
    musnix.url = "github:musnix/musnix";

    # Color customization
    nix-colors.url = "github:misterio77/nix-colors";

    # Spicetify 
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Overwitch - An overbridge compat layer
    overwitch = {
       url = "github:Are10/flake-overwitch/main";
       inputs.nixpkgs.follows = "nixpkgs";
    };
    
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

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, grub2-themes, spicetify-nix, overwitch, ... }:

    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
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
            overwitch.nixosModules.default
          ];
        };
      };
    };
}
