{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.zsh.enable = lib.mkEnableOption "zsh";

  # Install zsh if desired
  config = lib.mkIf config.zsh.enable {

    home.file.".config/bat/themes/rose-pine-moon.tmTheme".source = ./bat/rose-pine-moon.tmTheme;

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initExtra = ''
      # Bat theme
      export BAT_THEME=rose-pine-moon
      
      # FZF Previews
      export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
      export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

      # Advanced customization of fzf options via _fzf_comprun function
      # - The first argument to the function is the name of the command.
      # - You should make sure to pass the rest of the arguments to fzf.
      _fzf_comprun() {
        local command=$1
        shift

        case "$command" in
          cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
          export|unset) fzf --preview "eval 'echo \''${}'"         "$@" ;;
          ssh)          fzf --preview 'dig {}'                   "$@" ;;
          *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
        esac
      }
      '';

      shellAliases = {
        ls = "eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions";
        dots = "cd ~/.dotfiles";
        cat = "bat";
        nf = "neofetch";

        # Nix specific 
        rebuild = "nh os switch ~/.dotfiles --ask";
        rebuild-dry = "nh os switch ~/.dotfiles --dry";
        rebuildhome = "nh home switch ~/.dotfiles --ask";
        update = "nix flake update";
        clean = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than 7d";
        nix-gc = "sudo nix-collect-garbage";
      };
      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";

      # Plugins
      oh-my-zsh = {
        enable = true;
        plugins = [ "1password" "thefuck" "git" "fzf"];
      };    
    };

    home.packages = with pkgs; [
      thefuck
      fzf
      dig
    ];

  };
}