{ config, lib, pkgs, ... }:
let
  cfg = config.programs.neovim;
in
{
  imports = [
    ./lsp.nix
  ];

  programs.neovim = lib.mkIf cfg.enable {
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      cloak-nvim
      dracula-nvim
      fidget-nvim
      nvim-treesitter.withAllGrammars
      plenary-nvim
      telescope-nvim
      trouble-nvim
      undotree
      vim-suda
    ] ++ (with pkgs.neovim-plugins; [
      yaml-companion-nvim
    ]);

    extraPackages = with pkgs; [
      ripgrep
      fd
    ];

    extraLuaConfig = lib.mkBefore #lua
      ''
        require "fidget".setup {}
        require "cloak".setup {
          enabled = true,
          cloak_character = "*",
          highlight_group = "Comment",
          patterns = {
            {file_pattern = {".env*",}, cloak_pattern = "=.+",},
          },
        }

        local trouble = require "trouble".setup {}
        require "telescope".setup {
          defaults = {layout_config = {horizontal = {width = 0.9}}},
        }
        require "yaml-companion".setup {}
        require "telescope".load_extension("yaml_schema")
        local telescope = require "telescope.builtin"

        require "nvim-treesitter.configs".setup {
          auto_install = false,
          indent = {enable = true, disable = {"python", "yaml"}},
          highlight = {enable = true, disable = {"yaml"}, additional_vim_regex_highlighting = true,},
        }

        vim.g.mapleader = " "
        vim.opt.guicursor = ""
        vim.opt.nu = true
        vim.opt.relativenumber = true
        vim.opt.wrap = false
        vim.opt.swapfile = false
        vim.opt.backup = false
        vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
        vim.opt.undofile = true
        vim.opt.conceallevel = 0
        vim.opt.ignorecase = true
        vim.opt.smartcase = true
        vim.opt.hlsearch = true
        vim.opt.incsearch = true
        vim.opt.scrolloff = 8
        vim.opt.signcolumn = "yes"
        vim.opt.sidescrolloff = 8
        vim.opt.tabstop = 4
        vim.opt.shiftwidth = 4
        vim.opt.expandtab = true
        vim.opt.smartindent = true
        vim.opt.termguicolors = true
        vim.opt.cursorline = true
        vim.opt.colorcolumn = "100"

        vim.keymap.set("n", "Q", "<nop>", {})

        vim.keymap.set("v", "<leader>y", '"+y', {})
        vim.keymap.set("n", "<leader>y", '"+yy', {})
        vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', {})
        vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', {})
        vim.keymap.set("i", "jj", "<Esc>")
        vim.keymap.set("n", "vv", "V", {})
        vim.keymap.set("n", "V", "v$", {})

        vim.keymap.set("c", "r!!", "SudaRead %")
        vim.keymap.set("c", "w!!", "SudaWrite %")

        vim.cmd("colorscheme dracula")

        vim.keymap.set("n", "<leader>pf", telescope.find_files)
        vim.keymap.set("n", "<C-p>", telescope.git_files)
        vim.keymap.set("n", "<leader>vh", telescope.help_tags)

        vim.keymap.set("n", "<leader>tt", function() trouble.toggle() end)
        vim.keymap.set("n", "[t", function() trouble.next {skip_groups = true, jump = true} end)
        vim.keymap.set("n", "]t", function() trouble.previous {skip_groups = true, jump = true} end)

        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
      '';
  };
}
