{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.modules.neovim.plugins.trouble;
in
{
  options.modules.neovim.plugins.trouble.enable = mkEnableOption "trouble-nvim";

  config = mkIf cfg.enable {
    programs.neovim = {
      plugins = with pkgs.vimPlugins; [ trouble-nvim ];

      extraLuaConfig = # lua
        ''
          require "trouble".setup {}
          vim.keymap.set("n", "<leader>tt", function()
              require "trouble".toggle()
          end)

          vim.keymap.set("n", "[t", function()
              require "trouble".next {
                  skip_groups = true,
                  jump = true,
              }
          end)

          vim.keymap.set("n", "]t", function()
              require "trouble".previous {
                      skip_groups = true,
                      jump = true,
                  }
          end)
        '';
    };
  };
}
