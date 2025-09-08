# CRUSH Development Guidelines

## Build Commands
- `nixos-rebuild switch --flake .#enix` - Build and switch to the NixOS configuration
- `nix build .#nixosConfigurations.enix.config.system.build.toplevel` - Build the NixOS system

## Code Style Guidelines
- Configuration is written in Nix language
- Modules should be organized in a hierarchical structure
- Use descriptive names for configuration options
- Follow existing patterns in the codebase
- Prefer using existing NixOS options over custom ones when possible

## File Organization
- `configs/` - Main system and home configurations
- `modules/` - Custom NixOS modules
- `homemanagermodules/` - Home Manager modules
- `packages/` - Custom package definitions

## Testing
- Test configuration changes with `nixos-rebuild build --flake .#enix` before switching
- For Home Manager changes, use `home-manager build` and `home-manager switch`

## Nix Specifics
- Use flakes for reproducible builds
- Pin dependencies in `flake.nix` inputs
- Follow Nix formatting conventions (indent with 2 spaces)
- Use `nix fmt` to format Nix files if available

## Project Structure Overview
This is a NixOS configuration using flakes with the following key directories:
- `configs/` - Contains main system configuration files (configuration.nix, hardware-configuration.nix, home.nix)
- `modules/` - Custom NixOS modules for system configuration
- `homemanagermodules/` - Home Manager modules for user environment
- `packages/` - Custom package definitions
- `flakes/` - Additional flake configurations (if any)

## Common Tasks
- To rebuild the system: `nixos-rebuild switch --flake .#enix`
- To test changes before switching: `nixos-rebuild build --flake .#enix`
- To update flakes: `nix flake update`