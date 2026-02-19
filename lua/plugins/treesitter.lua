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
                "terraform",
                "just",
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

        -- map the filetype(s) to the correct parser name (in cases where it didn't work automatically)
        vim.treesitter.language.register("terraform", { "terraform", "tf", "terraform-vars" })

        -- Auto-enable for ALL file types
        vim.api.nvim_create_autocmd("BufReadPost", {
            pattern = "*",
            callback = function()
                local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
                if lang and pcall(vim.treesitter.language.inspect, lang) then
                    vim.treesitter.start()
                else
                    vim.notify("No Tree-sitter parser for filetype: " .. vim.bo.filetype, vim.log.levels.INFO)
                end
            end,
        })
    end,
}
