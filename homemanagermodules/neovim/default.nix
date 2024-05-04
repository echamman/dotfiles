{ config, pkgs, lib, inputs, ... }:

{

  # Add enable 
  options.neovim.enable = lib.mkEnableOption "neovim";

  # Install neovim if desired
  config = lib.mkIf config.neovim.enable {

    # neovim 
    programs.nixvim = {
      enable = true;

      # Replace vi and vim aliases with neovim
      viAlias = true;
      vimAlias = true;

      options = {
        number = true;
        relativenumber = true;

        shiftwidth = 2;
      };

      #extraConfigVim = lib.fileContents ./init.lua;

      colorschemes.rose-pine = {
        enable = true;
        settings = {
          variant = "moon";
        };
      };

      plugins = {
        telescope = {
          enable = true;

          enabledExtensions = [ "ui-select" ];
          extensions.ui-select.enable = true;
          extensions.frecency.enable = false;
          extensions.fzf-native.enable = true;
          
          extensions.file-browser = {
            enable = true;
            settings.hidden = true;
            settings.depth = 9999999999;
            settings.auto_depth = true;
          };
          keymaps = {
            "<leader>ff" = "find_files";
            "<leader>fs" = "grep_string";
            "<leader>fg" = "live_grep";
          };
          settings = {
            pickers = {
              find_files = {
                hidden = true;
              };
            };
          };
        };

        oil.enable = true;
        
        lualine.enable = true;

        treesitter.enable = true;

        luasnip.enable = true;

        alpha = {
          enable = true;
          iconsEnabled = true;
          opts = {};
          layout = [
            {
              type = "padding";
              val = 2;
            }
            {
              type = "text";
              val = [
                "███╗   ██╗██╗██╗  ██╗██╗   ██╗██╗███╗   ███╗"
                "████╗  ██║██║╚██╗██╔╝██║   ██║██║████╗ ████║"
                "██╔██╗ ██║██║ ╚███╔╝ ██║   ██║██║██╔████╔██║"
                "██║╚██╗██║██║ ██╔██╗ ╚██╗ ██╔╝██║██║╚██╔╝██║"
                "██║ ╚████║██║██╔╝ ██╗ ╚████╔╝ ██║██║ ╚═╝ ██║"
                "╚═╝  ╚═══╝╚═╝╚═╝  ╚═╝  ╚═══╝  ╚═╝╚═╝     ╚═╝"
              ];
              opts = {
                position = "center";
                hl = "Type";
              };
            }
            {
              type = "padding";
              val = 2;
            }
            {
              type = "group";
              opts = {
                position = "center";
              };
              val = [
                {
                  type = "button";
                  val = "  Find Projects";
                  on_press.__raw =
                    /*
                    lua
                    */
                    ''
                      function()
                        vim.cmd[[
                          Telescope projects
                        ]]
                      end
                    '';
                  opts = {
                    hl = "hl_group";
                    position = "center";
                    align_shortcut = "right";
                    hl_shortcut = "hl_group";
                    cursor = 0;
                    width = 50;
                    shrink_margin = true;
                    shortcut = "<leader>fp";
                  };
                }
              ];
            }
            {
              type = "padding";
              val = 2;
            }
            {
              type = "text";
              val = "Why use C?";
              opts = {
                position = "center";
                hl = "Keyword";
              };
            }
          ];
        };
      };

      plugins.nvim-colorizer = {
        enable = true;
        fileTypes = [ "*" ];
      };

      extraPlugins = with pkgs.vimPlugins; [ 
        plenary-nvim
      ];

    };
  };
}