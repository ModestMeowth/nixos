{config, lib, pkgs, ...}: {
  options.hm-mm.editor.nvim.telescope = lib.mkEnableOption "telescope";

  config = lib.mkIf config.hm-mm.editor.nvim.telescope {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        telescope-nvim
        plenary-nvim
      ];

      extraPackages = with pkgs; [
        ripgrep
        fd
      ];

      extraLuaConfig =
        /*
        lua
        */
        ''
          -- Telescope
          local telescope = require "telescope".setup {
            defaults = {
              layout_config = {
                horizontal = {
                  width = 0.9,
                },
              },
            },
          }

          local tbuiltin = require "telescope.builtin"

          vim.keymap.set("n", "<leader>pf", tbuiltin.find_files)
          vim.keymap.set("n", "<C-p>", tbuiltin.git_files)
          vim.keymap.set("n", "<leader>vh", tbuiltin.help_tags)
        '';
    };
  };
}
