{ config
, lib
, pkgs
, ...
}:
with lib;
let
  cfg = config.modules.neovim.plugins.treesitter;
in
{
  options.modules.neovim.plugins.treesitter.enable = mkEnableOption "nvim-treesitter";

  config = mkIf cfg.enable {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];

      extraLuaConfig = # lua
        ''
          -- Treesitter
          require "nvim-treesitter.configs".setup {
            auto_install = false,
            indent = {
              enable = true,
              disable = {
                "python",
                "yaml"
              },
            },
            highlight = {
              enable = true,
              disable = {
                "yaml",
              },
              additional_vim_regex_highlighting = true,
            },
          }
        '';
    };
  };
}
