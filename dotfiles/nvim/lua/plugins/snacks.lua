return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        dim = {},
        explorer = {},
        git = {},
        indent = {},
        input = {},
        picker = {},
        win = {},
        words = {},
    },
    keys = {
        { "<leader>.", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
        { "<leader>fr", function() Snacks.picker.smart { matcher = { frecency = true } } end, desc = "Recently opened files" },
        { "<leader>fp", function() Snacks.picker.files{ cwd = vim.fn.stdpath"config" } end, desc = "Find Config File" },
        { "<leader>e", function() Snacks.explorer() end, desc = "File Explorer" },
        { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git blame line" },
    },
}
