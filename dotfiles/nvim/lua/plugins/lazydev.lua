return {
  "folke/lazydev.nvim",
  ft = "lua",
  config = function()
    require("lazydev").setup()
    vim.lsp.enable("lua_ls")
    vim.lsp.config("lua_ls", {
      root_dir = function(bufnr, on_dir)
        on_dir(lazydev.find_workspace(bufnr))
      end,
    })
  end,
}
