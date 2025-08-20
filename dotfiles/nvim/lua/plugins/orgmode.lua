return {
    {
        "chipsenkbeil/org-roam.nvim",
        dependencies = {
            "nvim-orgmode/orgmode",
        },
        config = function()
            require"org-roam".setup {
                directory = "~/org/roam",
            }
        end,
    },
    {
        "nvim-orgmode/orgmode",
        dependencies = {
            "akinsho/org-bullets.nvim",
            "lukas-reineke/headlines.nvim",
        },
        event = "VeryLazy",
        ft = { "org" },
        config = function()
            require"orgmode".setup {
                org_agenda_files = "~/org/**/*",
                org_default_notes_file = "~/org/refile.org",
            }
        end,
    },
}
