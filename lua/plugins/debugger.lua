return {
	-- Go debugger (delve) ----------------------------------------------------
	{
		"leoluz/nvim-dap-go",
		ft = "go",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function(_, opts)
			require("dap-go").setup(opts or {})
			local dap = require("dap")

			-- Ensure go config table exists
			dap.configurations.go = dap.configurations.go or {}

			-- Add a custom configuration to run main.go from anywhere
			table.insert(dap.configurations.go, {
				type = "go",
				name = "Debug (Main)",
				request = "launch",
				program = function()
					-- Prompt for path, defaulting to main.go in cwd
					return vim.fn.input("Path to main.go: ", vim.fn.getcwd() .. "/main.go", "file")
				end,
			})
		end,
	},

	-- DAP-UI -----------------------------------------------------------------
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		keys = {
			{
				"<leader>du",
				function()
					require("dapui").toggle()
				end,
				desc = "Toggle Dap UI",
			},
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- 1. setup the UI *first*
			dapui.setup()
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
			-- 2. register open/close listeners
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			vim.cmd("hi DapBreakpointColor guifg=#fa4848")
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "", texthl = "DapBreakpointColor", linehl = "", numhl = "" }
			)
			vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
		end,
	},

	-- DAP core ---------------------------------------------------------------
	{
		"mfussenegger/nvim-dap",
		keys = {
			{
				"<leader>b",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle Breakpoint",
			},
			{
				"<leader>dc",
				function()
					require("dap").continue()
				end,
				desc = "Run/Continue",
			},
			-- { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into" },
			{
				"<leader>dO",
				function()
					require("dap").step_over()
				end,
				desc = "Step Over",
			},
			-- { "<leader>do", function() require("dap").step_out() end,          desc = "Step Out" },
			-- { "<leader>dr", function() require("dap").restart() end,         desc = "Restart" },
			{
				"<leader>?",
				function()
					require("dapui").eval(nil, { enter = true })
				end,
				desc = "Eval under cursor",
			},

			-- Add to watches
			{
				"<leader>dw",
				function()
					require("dapui").elements.watches.add()
				end,
				desc = "Add to Watches",
			},

			-- Add visual selection to watches
			{
				"<leader>dw",
				function()
					require("dapui").elements.watches.add(vim.fn.expand("<cword>"))
				end,
				desc = "Add word to Watches",
				mode = "v",
			},
			{
				"<leader>dW",
				function()
					require("dapui").float_element("watches", { enter = true })
				end,
				desc = "Float Watches",
			},
		},
	},
}
