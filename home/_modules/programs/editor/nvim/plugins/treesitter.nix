{config, lib, pkgs, ...}: {
  options.hm-mm.editor.nvim.treesitter = lib.mkEnableOption "nvim-treesitter";

  config = lib.mkIf config.hm-mm.editor.nvim.treesitter {
    programs.neovim = {
      plugins = [ pkgs.vimPlugins.nvim-treesitter.withAllGrammars ];

      extraLuaConfig =
        /*
        lua
        */
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
