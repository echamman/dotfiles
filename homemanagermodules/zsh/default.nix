{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.zsh.enable = lib.mkEnableOption "zsh";

  # Install zsh if desired
  config = lib.mkIf config.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      shellAliases = {
        ll = "ls -l";
        rebuild = "nixos-rebuild switch --flake ~/.dotfiles#default --use-remote-sudo";
        rebuild-verbose = "nixos-rebuild switch --flake ~/.dotfiles#default --use-remote-sudo --show-trace --verbose";
        update = "nix flake update";
        clean = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d";
        nix-gc = "sudo nix-collect-garbage";
      };
      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";

      # Plugins
      oh-my-zsh = {
        enable = true;
        plugins = [ "1password" "thefuck" "git"];
      };
    };

    home.packages = with pkgs; [
      thefuck
    ];

  };
}