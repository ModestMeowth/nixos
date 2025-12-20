{ config, ...}:
let
  HOME = config.home.homeDirectory;
in {
  imports = [
    ./cmp.nix
    ./diagnostics.nix
    ./fidget.nix
    ./lsp.nix
    ./notes.nix
    ./snacks.nix
    ./treesitter.nix
    ./which-key.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    luaLoader.enable = true;

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "macchiato";
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };

    globals = {
      mapleader = " ";
      maplocalleader = ",";
    };

    opts = {
      guicursor = "";
      swapfile = false;
      backup = false;

      undofile = true;
      undodir = "${HOME}/.local/state/nvim/undodir";

      ruler = true;
      nu = true;
      relativenumber = true;
      scrolloff = 8;
      sidescrolloff = 8;
      wrap = false;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;

      viewoptions = "folds,cursor";
      sessionoptions = "folds";

      foldmethod = "expr";
      foldexpr = "v:lua.nvim_treesitter#foldexpr()";
      foldlevelstart = 5;

      splitbelow = true;
      splitright = true;
    };

    keymaps = [
      {
        action = "<nop>";
        key = "Q";
        mode = "n";
      }
      {
        action = ''"+y'';
        key = "<leader>y";
        mode = [ "n" "v" ];
      }
      {
        action = ''"+Y'';
        key = "<leader>Y";
        mode = "n";
      }
      {
        action = ''"+p'';
        key = "<leader>p";
        mode = [ "n" "v" ];
      }
      {
        action = ''"+P'';
        key = "<leader>P";
        mode = [ "n" "v" ];
      }
      {
        action = "vim.lsp.buf.hover";
        key = "<leader>k";
        mode = "n";
      }
    ];
  };
}
