local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = (' 󰁂 %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
        local chunkText = chunk[1]
        local chunkWidth = vim.fn.strdisplaywidth(chunkText)
        if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
        else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
        end
        curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
end

return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
        -- foldlevel: sets the fold level for the current window.
        -- 99 is a high value that effectively means "all folds are open".
        -- This prevents any folds from being closed when you manually open them.
        vim.o.foldlevel = 99

        -- foldlevelstart: sets the initial fold level when opening a new buffer.
        -- 99 ensures that when you enter a new file, all folds start unfolded.
        -- This is the key setting that stops files from being folded by default on entry.
        vim.o.foldlevelstart = 99

        -- foldenable: must be true for nvim-ufo to function.
        -- Even though we want everything open, ufo needs folding enabled
        -- to provide its enhanced fold features (like virtual text and smooth animations).
        vim.o.foldenable = true

        require("ufo").setup({
            -- fold_virt_text_handler: custom function to format the virtual text shown on folded lines.
            -- It truncates the folded line content and appends a suffix showing the number of hidden lines.
            -- This provides a cleaner, more informative fold indicator than the default.
            fold_virt_text_handler = handler,
            -- provider_selector: tells ufo which fold providers to use.
            -- "treesitter" provides semantic folding based on AST (functions, classes, etc.).
            -- "indent" is the fallback for files without Tree-sitter support.
            provider_selector = function(bufnr, filetype, buftype)
                return { "treesitter", "indent" }
            end,
        })


        -- Disable all native fold keymaps except zo (open) and zc (close).
        -- We map them to <Nop> (no operation) so they do nothing when pressed.
        -- This enforces the constraint that only zo and zc are available.
        local disabled_folds = { "zO", "zC", "zA", "zM", "zR", "zv", "zx", "zX", "zm", "zr", "zn", "zN", "zi", "za" }
        for _, key in ipairs(disabled_folds) do
            vim.keymap.set("n", key, "<Nop>", { noremap = true, silent = true })
        end
    end,
}
