{ config, pkgs, lib, inputs, ... }:

{
      
  # Add enable 
  options.neovim.enable = lib.mkEnableOption "neovim";

  # Install neovim if desired
  config = lib.mkIf config.neovim.enable {

    # neovim 
    programs.nixneovim = {
      enable = true;

      # Replace vi and vim aliases with neovim
      viAlias = true;
      vimAlias = true;

      extraConfigVim = lib.fileContents ./init.vim;

      colorschemes.rose-pine = {
        enable = true;
        variant = "moon";
      };

      plugins = {
        plenary = {
          enable = true;
        };

        nvim-tree = {
          enable = true;
        };

        telescope = {
          enable = true;
        };
      };

      extraPlugins = with pkgs.vimExtraPlugins; [ 
        tmux-nvim
	      alpha-nvim
        #neovim-tmux-navigator
      ];
      
    };
  };
}
