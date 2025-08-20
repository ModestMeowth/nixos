vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.guicursor = ""
vim.opt.clipboard = "unnamedplus"

vim.opt.ruler = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.viewoptions = "folds,cursor"
vim.opt.sessionoptions = "folds"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 5

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.cmd("colorscheme dracula")
