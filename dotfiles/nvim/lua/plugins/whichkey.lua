return {
    "folke/which-key.nvim",
    dependencies = {},
    event = "VeryLazy",
    opts = {
        triggers = {
            { "<auto>", mode = "nixsotc" },
            { "a", mode = { "n", "v" } },
        },
    },
    keys = {
        {
            "<leader>?", function()
                require("which-key").show({ global = false })
            end, desc = "Buffer local keymaps (which-key)",
        },
    },
}
