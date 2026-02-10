return {
    -- 1. Run tests in nvim
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "antoinemadec/FixCursorHold.nvim",
            {
                "fredrikaverpil/neotest-golang",
                version = "*",
                build = function()
                    vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
                end,
            },
        },
        keys = {
            { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,                      desc = "[t]est run [f]ile" },
            { "<leader>tA", function() require("neotest").run.run(vim.uv.cwd()) end,                            desc = "[t]est [A]ll files" },
            { "<leader>tS", function() require("neotest").run.run({ suite = true }) end,                        desc = "[t]est [S]uite" },
            { "<leader>tn", function() require("neotest").run.run() end,                                        desc = "[t]est [n]earest" },
            { "<leader>ts", function() require("neotest").summary.toggle() end,                                 desc = "[t]est [s]ummary" },
            { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "[t]est [o]utput" },
            { "<leader>tO", function() require("neotest").output_panel.toggle() end,                            desc = "[t]est [O]utput panel" },
            { "<leader>te", function() require("neotest").run.stop() end,                                       desc = "[t]est [t]erminate" },
        },
        config = function()
            -- local config = {
            --     runner = "gotestsum",
            -- }
            local neotest_golang_opts = {
                runner = "go",
                go_test_args = {
                    "-v",
                    -- "-race",
                    "-count=1",
                    "-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
                },
            }
            require("neotest").setup({
                adapters = {
                    require("neotest-golang")(neotest_golang_opts),
                },
            })
        end,
    },
    -- 2. Explore coverage
    {
        "andythigpen/nvim-coverage",
        version = "*",
        config = function()
            require("coverage").setup({
                auto_reload = true,
                highlights = {
                    -- customize highlight groups created by the plugin
                    covered = { fg = "#C3E88D" }, -- supports style, fg, bg, sp (see :h highlight-gui)
                    uncovered = { fg = "#F07178" },
                },
                signs = {
                    -- use your own highlight groups or text markers
                    covered = { hl = "CoverageCovered", text = "▎" },
                    uncovered = { hl = "CoverageUncovered", text = "▎" },
                },
                summary = {
                    -- customize the summary pop-up
                    min_coverage = 80.0, -- minimum coverage threshold (used for highlighting)
                },
                lang = {
                    go = {
                        coverage_file = vim.fn.getcwd() .. '/coverage.out'
                    }
                },

            })
        end,
    },
}
