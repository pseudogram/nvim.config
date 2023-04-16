local builtin = require('telescope.builtin')

-- Project fuzzy search Files
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

-- Project search All, sometimes you need to look at hidden files.
vim.keymap.set('n', '<leader>pa', function()
	builtin.find_files({hidden=true})
end)
-- Project search Everything, sometimes you wanna looka at node modules
vim.keymap.set('n', '<leader>pe', function()
	builtin.find_files({no_ignore=true, hidden=true})
end)

-- Project search git files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})

-- Project Search - all your normal day to day files
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("grep 🔍 >") })
end)

-- Project search Live grep
vim.keymap.set('n', '<leader>pl', builtin.live_grep, {})

-- Telescope to search and View all Help pages
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

