return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        local utils = require('pseudogram.utils')

        telescope.setup({
            defaults = {
                path_display = {
                    "smart"
                },
                dynamic_preview_title = true
            },
        })

        -- local builtin = require('telescope.builtin')
        -- local utils = require('pseudogram.utils')

        telescope.setup({
            defaults = {
                path_display = {
                    "smart"
                },
                dynamic_preview_title = true
            },
        })

        -- Project fuzzy search Files
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        -- Project fuzzy search Files
        -- vim.keymap.set('n', '<leader>pf',function()
        --     builtin.find_files()
        -- end, {})

        -- Project search All, sometimes you need to look at hidden files.
        vim.keymap.set('n', '<leader>pa', function()
            builtin.find_files({ hidden = true, })
        end)
        -- Project search Everything, sometimes you wanna looka at node modules
        vim.keymap.set('n', '<leader>pe', function()
            builtin.find_files({ no_ignore = true, hidden = true })
        end)

        -- Project search git files
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})

        -- Project Search - all your normal day to day files
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("grep 🔍 >") })
        end)

        -- Project Search - all your normal day to day files USING REGEX
        vim.keymap.set('n', '<leader>pr', function()
            builtin.grep_string({ search = vim.fn.input("grep regex 🔍 >"), use_regex = true })
        end)

        -- Project Search string under cursor
        vim.keymap.set('n', '<leader>ys', function()
            builtin.grep_string()
        end)

        -- Project Search selection under cursor
        vim.keymap.set('v', '<leader>ys', function()
            local visual_selection = utils.get_visual_selection()
            builtin.grep_string({ search = visual_selection })
        end)

        -- Project search Live grep
        vim.keymap.set('n', '<leader>pl', builtin.live_grep, {})

        -- Telescope to search and View all Help pages
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end,
}
