return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",
  priority = 1000,
  config = function()
    require("tiny-inline-diagnostic").setup({
      transparent_bg = false,
      options = {
        use_icons_from_diagnostics = true,
        multilines = { enabled = true },
        enable_on_insert = true,
        show_all_diags_on_cursorline = true,
      },
    })
    vim.diagnostic.config({ virtual_text = true })
  end,
}
