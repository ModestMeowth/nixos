return {
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        require"nvim-treesitter.configs".setup {
          ensure_installed = { "lua", "nix" },
          sync_install = false,
          auto_install = true,
          indent = { enable = true },
          highlight = { enable = true, additonal_vim_regex_highlighting = { "markdown" } },
          fold = { enable = true, },
        }
      end,
    },
}
