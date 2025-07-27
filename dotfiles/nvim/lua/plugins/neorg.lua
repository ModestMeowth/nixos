return {
  "nvim-neorg/neorg",
  dependencies = {
    "benlubas/neorg-interim-ls",
    --"dhruvasagar/vim-table-mode",
    "akinsho/org-bullets.nvim",
  },
  lazy = false,
  version = "*",
  config = {
    load = {
      ["core.defaults"] = {},
      ["core.dirman"] = {
        config = {
          default_workspace = "org",
          workspaces = { org = "~/org" },
        },
      },
      ["core.completion"] = {
        config = { engine = { module_name = "external.lsp-completion" } },
      },
      ["external.interim-ls"] = {
        config = {
          enable = true,
          documentation = true,
        },
      },
      ["core.keybinds"] = {
        config = {
          default_keybinds = true,
          neorg_leader = "<LocalLeader>",
        },
      },
      ["core.tangle"] = {
        config = {
          tangle_on_write = true,
        },
      },
    },
  },
}
