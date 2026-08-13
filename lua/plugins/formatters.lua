return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters = {
                -- Lua
                stylua = {
                    command = "stylua",
                    args = { "-" },
                    stdin = true,
                },

                -- Go
                goimports = {
                    command = "goimports",
                    stdin = true,
                },
                gofumpt = {
                    command = "gofumpt",
                    stdin = true,
                },
                swag = {
                    command = "swag",
                    args = { "fmt", "-d", "." },
                    stdin = false,
                },

                -- Python
                black = {
                    command = "black",
                    args = { "--quiet", "-" },
                    stdin = true,
                },
                isort = {
                    command = "isort",
                    args = { "--quiet", "-" },
                    stdin = true,
                },

                -- Nix
                alejandra = {
                    command = "alejandra",
                    args = { "--quiet" },
                    stdin = true,
                },

                -- Terraform
                terraform = {
                    command = "terraform-ls",
                    args = { "serve" },
                    filetypes = { "terraform", "tf" },
                },

                -- Yaml
                yamlfmt = {
                    command = "yamlfmt",
                    args = { "-formatter", "retain_line_breaks_single=true", "-" },
                    stdin = true,
                    filetypes = { "yaml", "yml" },
                },

                -- JSON
                deno_fmt = {
                    command = "deno",
                    args = { "fmt", "--indent-width", "4", "--ext", "json", "-" },
                    stdin = true,
                    filetypes = { "json" },
                },
            },

            formatters_by_ft = {
                lua = { "stylua" },
                go = { "goimports", "gofumpt" },
                python = { "black", "isort" },
                nix = { "alejandra" },
                terraform = { "terraform-ls" },
                yaml = { "yamlfmt" },
                json = { "deno_fmt" },
            },

            -- Format on save
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
        },
        keys = {
            {
                "<leader>f",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = { "n", "v" }, -- n = normal mode & v = visual mode
                desc = "Format buffer",
            },
            {
                "<leader>gs",
                function()
                    local result = vim.system({ "swag", "fmt", "-d", "." }, { cwd = vim.fn.getcwd() }):wait()
                    if result.code == 0 then
                        vim.notify("swag fmt completed", vim.log.levels.INFO)
                    else
                        vim.notify("swag fmt failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
                    end
                end,
                mode = "n",
                desc = "Format Swaggo comments",
            },
        },
    },
}
