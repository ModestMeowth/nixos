{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./plugins
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      dracula-nvim
      undotree
      cloak-nvim
    ];

    extraLuaConfig =
      /*
      lua
      */
      lib.mkBefore ''
        vim.g.mapleader = " "
        vim.opt.guicursor = ""
        vim.opt.nu = true
        vim.opt.relativenumber = true
        vim.opt.wrap = false
        vim.opt.swapfile = false
        vim.opt.backup = false
        vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
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
        vim.opt.colorcolumn = "80"
        vim.cmd("colorscheme dracula")

        vim.keymap.set("n", "Q", "<nop>", {})

        vim.keymap.set("v", "<leader>y", '"+y', {})
        vim.keymap.set("n", "<leader>y", '"+yy', {})
        vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', {})
        vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', {})
        vim.keymap.set("i", "jj", "<Esc>")
        vim.keymap.set("n", "vv", "V", {})
        vim.keymap.set("n", "V", "v$", {})
      '';
  };
}
