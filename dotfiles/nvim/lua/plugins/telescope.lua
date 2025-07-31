return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require"telescope".setup {
            live_grep = {
                find_command = "rga",
            }
        }
    end,
    keys = {
        { "<leader>pf", "<cmd>Telescope find_files<CR>", desc = "Telescope find files" },
        { "<leader>pg", "<cmd>Telescope live_grep<CR>", desc = "Telescope live grep" },
    }
}
