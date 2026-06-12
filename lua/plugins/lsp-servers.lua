return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- 1. register the servers
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = { Lua = { workspace = { checkThirdParty = false } } },
            })

            vim.lsp.config("gopls", {
                capabilities = capabilities,
                settings = { gopls = { analyses = { unusedparams = true }, staticcheck = true } },
            })

            vim.lsp.config("pyright", {
                capabilities = capabilities,
                settings = {
                    pyright = { autoImportCompletion = true },
                    python = {
                        analysis = {
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            -- nixd: build options config based on hostname
            local nixd_options = {}
            local hostname = vim.fn.hostname():gsub("%.local$", "")

            -- NixOS machines: point at the system flake for full option completion
            if hostname == "nixos-btw" or hostname == "nixos-laptop" then
                nixd_options.nixos = {
                    expr = '(builtins.getFlake (toString ~/nixos-config)).nixosConfigurations.'
                        .. hostname
                        .. ".options",
                }
            end

            vim.lsp.config("nixd", {
                capabilities = capabilities,
                settings = {
                    nixd = {
                        nixpkgs = {
                            expr = 'import (builtins.getFlake "nixpkgs") { }',
                        },
                        formatting = {
                            command = { "nixfmt" },
                        },
                        options = nixd_options,
                    },
                },
            })

            vim.lsp.config("terraformls", {
                capabilities = capabilities,
            })

            vim.lsp.config("just-lsp", {
                capabilities = capabilities,
            })

            -- 2. enable them
            vim.lsp.enable({ "lua_ls", "gopls", "pyright", "nixd", "terraformls", "just-lsp" })
        end,
    },
}
