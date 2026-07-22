return {
    {
        'stevearc/overseer.nvim',
        ---@module 'overseer'
        ---@type overseer.SetupOpts
        opts = {
            -- Open the task list on the left side
            task_list = {
                direction = "left",
            },
            -- Add a border to the floating preview window
            task_win = {
                border = "rounded",
            },
        },
        config = function(_, opts)
            require("overseer").setup(opts)
        end,
    }
}
