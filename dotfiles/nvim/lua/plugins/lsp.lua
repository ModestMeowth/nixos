return {
  {
    "WieeRd/auto-lsp.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    event = "VeryLazy",
    opts = {},
    config = function()
      require("auto-lsp").setup({
        ["harper_ls"] = true,
        ["bashls"] = true,
      })
    end,
  },
}
