return {
    -- 1. Disable the Mason-related plugins
    { "williamboman/mason.nvim",                   enabled = false },
    { "williamboman/mason-lspconfig.nvim",         enabled = false },
    { "WhoIsSethDaniel/mason-tool-installer.nvim", enabled = false },

    -- 2. Minimal lspconfig setup
    {
        "neovim/nvim-lspconfig",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        opts = {
            diagnostics = {
                virtual_text = true,
                signs = true,
                underline = true,
            },
        },
        config = function(_, opts)
            -- apply diagnostic look-and-feel
            vim.diagnostic.config(opts.diagnostics)
        end,
    },

    -- 3. LSP Function Signature
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            bind = true,                                  -- mandatory in recent versions
            floating_window = true,                       -- show popup
            hint_enable = false,                          -- virtual-text clutters, turn off
            hi_parameter = "LspSignatureActiveParameter", -- highlight of active parameter
            fix_pos = false,                              -- set to true, the floating window will not auto-close until finish all parameters
            handler_opts = { border = "rounded" },
        },
        config = function(_, opts)
            require("lsp_signature").setup(opts)
        end,
    }
}
