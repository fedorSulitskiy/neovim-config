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

-- Go Coverage
vim.keymap.set('n', '<leader>tc', '<Cmd>Coverage<CR>', { desc = '[t]oggle [c]overage signs' })
vim.keymap.set('n', '<leader>tC', function()
    require('coverage').clear()
end, { desc = '[t]est clear [C]overage signs' })
