local function is_whitespace(line)
    return vim.fn.match(line, [[^\s*$]]) ~= -1
end

local function all(tbl, check)
    for _, entry in ipairs(tbl) do
        if not check(entry) then
            return false
        end
    end
    return true
end

return {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
        require('neoclip').setup({
            -- If you don't want to store pure whitespace yanks you could specify a filter as:
            filter = function(data)
                return not all(data.event.regcontents, is_whitespace)
            end,

            -- Track the + register (system clipboard) by default.
            -- With `unnamedplus` set in vim-options.lua, the " register
            -- is synced to +, so this captures both Neovim yanks and
            -- external clipboard copies.
            --
            -- Also track the * register (primary/selection clipboard on macOS)
            default_register = { '+', '*' },

            -- Remap paste from <c-p> to Enter in insert mode
            keys = {
                telescope = {
                    i = {
                        paste = '<cr>',
                        select = '<c-y>',
                    },
                },
            },
        })
    end,
}
