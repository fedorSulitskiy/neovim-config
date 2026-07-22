-- Code Actions
vim.keymap.set("n", "K", vim.lsp.buf.hover, {})

-- Git
vim.keymap.set("n", "<leader>gph", ":Gitsigns preview_hunk<CR>", {})
vim.keymap.set("n", "<leader>gpi", ":Gitsigns preview_hunk_inline<CR>", {})
vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", {})

-- NeoTree
vim.keymap.set("n", "<C-b>", ":Neotree filesystem reveal left<CR>", {})

-- Render Markdown toggle
vim.keymap.set("n", "<leader>mr", function()
    require('render-markdown').toggle()
end, { desc = "Toggle Rendered Markdown" })

-- Go Tagger
vim.keymap.set("v", "<leader>at", ":AddGoTags<CR>", { desc = "Add Go struct tags", silent = true })
vim.keymap.set("v", "<leader>rt", ":RemoveGoTags<CR>", { desc = "Remove Go struct tags", silent = true })

-- Diagnostics
vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })

-- Git Hunk
vim.keymap.set("n", "]c", function()
    if vim.wo.diff then return "]c" end
    vim.schedule(function() require("gitsigns").next_hunk() end)
    return "<Ignore>"
end, { desc = "Next hunk", expr = true })

vim.keymap.set("n", "[c", function()
    if vim.wo.diff then return "[c" end
    vim.schedule(function() require("gitsigns").prev_hunk() end)
    return "<Ignore>"
end, { desc = "Previous hunk", expr = true })

-- Git Diff
vim.keymap.set("n", "<leader>dd", "<cmd>Lazydiff<cr>", { desc = "Toggle lazydiff" })

-- Overseer
vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<cr>", { desc = "Toggle overseer window", silent = true })
vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>", { desc = "Run overseer task", silent = true })

-- Coverage
vim.keymap.set('n', '<leader>tc', '<Cmd>Coverage<CR>', { desc = '[t]oggle [c]overage signs' })
vim.keymap.set('n', '<leader>tC', function()
    require('coverage').clear()
end, { desc = '[t]est clear [C]overage signs' })

-- Neoclip clipboard history
vim.keymap.set("n", "<leader>nc", ":Telescope neoclip<CR>", { desc = "Neoclip clipboard history" })
vim.keymap.set("n", "<leader>nm", ":Telescope macroscope<CR>", { desc = "Neoclip macro history" })
