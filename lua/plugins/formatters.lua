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
			},

			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofumpt", "swag" },
				python = { "black", "isort" },
				nix = { "alejandra" },
				terraform = { "terraform-ls" },
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
		},
	},
}
