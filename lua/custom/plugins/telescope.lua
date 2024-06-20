return {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        local utils = require('pseudogram.utils')
        local telescopeConfig = require("telescope.config")

        -- Clone the default Telescope configuration
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- I want to search in hidden/dot files.
        table.insert(vimgrep_arguments, "--hidden")
        -- I don't want to search in the `.git` directory.
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")


        telescope.setup({
            defaults = {
                path_display = {
                    "smart"
                },
                dynamic_preview_title = true,

                -- `hidden = true` is not supported in text grep commands.
                vimgrep_arguments = vimgrep_arguments,
            },
            pickers = {
                find_files = {
                    -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
                },
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

        -- Project File search for selection under cursor
        vim.keymap.set('v', '<leader>y', function()
            local visual_selection = utils.get_visual_selection()
            builtin.find_files({ search_file = visual_selection })
        end)

        -- Project search Live grep
        vim.keymap.set('n', '<leader>pl', builtin.live_grep, {})

        -- Telescope to search and View all Help pages
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end,
}
