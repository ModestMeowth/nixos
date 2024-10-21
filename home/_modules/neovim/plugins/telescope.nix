{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.neovim.plugins.telescope;
in
{
  options.modules.neovim.plugins.telescope.enable = mkEnableOption "telescope";

  config = mkIf cfg.enable {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [
        telescope-nvim
        plenary-nvim
      ];

      extraPackages = with pkgs; [
        ripgrep
        fd
      ];

      extraLuaConfig = # lua
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
