{
  description = "Ethan's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";

    # Nix User Repository; NUR
    nur.url = "github:nix-community/NUR";

    # Nix Gaming 
    nix-gaming.url = "github:fufexan/nix-gaming";

    # Older orca slicer package
    old-orcaslicer-nixpkgs.url = "github:nixos/nixpkgs/e6f23dc08d3624daab7094b701aa3954923c6bbb";

    # Pin darktable
    old-darktable-nixpkgs.url = "github:nixos/nixpkgs/c48b594afc3079d26a1393494c68c01c82c73180";
    
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

    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Nixvim 
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/de77ec882dce3dd60e9e5431d375e64fd58bdc74";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, nix-gaming, nur, home-manager, grub2-themes, spicetify-nix, overwitch, lsfg-vk-flake, lanzaboote, ... }:

    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = nixpkgs-stable.legacyPackages.${system};
      pkgs-gaming = nix-gaming.packages.${pkgs.hostPlatform.system};
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
            nur.modules.nixos.default
            grub2-themes.nixosModules.default
            inputs.musnix.nixosModules.musnix
            overwitch.nixosModules.default
            lsfg-vk-flake.nixosModules.default
            lanzaboote.nixosModules.lanzaboote
          ];
        };
      };
    };
}
