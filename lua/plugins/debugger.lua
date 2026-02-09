return {
  -- Go debugger (delve) ----------------------------------------------------
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {},                       -- use defaults
  },

  -- DAP-UI -----------------------------------------------------------------
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle Dap UI" },
    },
    config = function()
      local dap  = require("dap")
      local dapui = require("dapui")

      -- 1. setup the UI *first*
      dapui.setup()

      -- 2. register open/close listeners
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]    = function() dapui.close() end
    end,
  },

  -- DAP core ---------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>b",  function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,          desc = "Run/Continue" },
      { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into" },
      { "<leader>dO", function() require("dap").step_over() end,         desc = "Step Over" },
      { "<leader>do", function() require("dap").step_out() end,          desc = "Step Out" },
      { "<leader>dr", function() require("dap").restart() end,         desc = "Restart" },
      { "<leader>?",  function() require("dapui").eval(nil,{enter=true}) end, desc = "Eval under cursor" },
    },
  },
}

