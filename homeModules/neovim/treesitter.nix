{ pkgs, ... }:
{
  programs.nixvim = {
    colorschemes.catppucchin.settings.integtrations.treesitter = true;

    plugins = {
      treesitter = {
        enable = true;

        grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;

        settings = {
          auto_install = false;
          fold.enable = true;
          highlight = {
            enable = true;
            additional_vim_regex_highlighting = true;
          };
          indent.enable = true;
        };
      };

      rainbow-delimiters.enable = true;
    };
  };
}
