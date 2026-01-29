return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    version = false,
    build = ":TSUpdate",
    config = function()
        -- Basic setup (but highlighting won't auto-enable)
        require("nvim-treesitter").setup({
            ensure_installed = {
                "go",
                "python",
                "c",
                "nix",
                "lua",
                "vim",
                "vimdoc",
                "query",
                "elixir",
                "heex",
                "javascript",
                "html",
            },
            auto_install = true,
        })

        -- -- MANUALLY enable highlighting for Go files
        -- vim.api.nvim_create_autocmd("FileType", {
        --     pattern = "go",
        --     callback = function()
        --         vim.treesitter.start()
        --     end,
        -- })

        -- Auto-enable for ALL file types
        vim.api.nvim_create_autocmd("BufReadPost", {
            pattern = "*",
            callback = function()
                -- Start treesitter for the current buffer
                vim.treesitter.start()
            end,
        })
    end,
}
