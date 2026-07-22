return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    },
    {
        "tpope/vim-fugitive",
    },
    {
        "rashedInt32/lazydiff.nvim",
        cmd = {
            "Lazydiff", "LazydiffOff", "LazydiffRefresh",
            "LazydiffNext", "LazydiffPrev", "LazydiffFirst",
        },
        config = function()
            require("lazydiff").setup()
        end,
    },
    {
        "folke/snacks.nvim",
        ---@type snacks.Config
        opts = {
            lazygit = {
                -- your lazygit configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        }
    },
}
