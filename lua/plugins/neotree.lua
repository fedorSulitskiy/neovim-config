return {
    {
        "nvim-tree/nvim-web-devicons",
        opts = {},
        config = function()
            require("nvim-web-devicons").setup({
                default = true,
            })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            close_if_last_window = false,
            filesystem = {
                filters = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_ignored = false,
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                        ".DS_Store",
                    }
                },
            },
        },
    },
}
