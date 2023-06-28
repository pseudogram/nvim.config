

local oil = require("oil")

oil.setup({
	columns = {
		"icon",
		"permissions"
	},
	default_file_explorer = false,
	use_default_keymaps = false,
	keymaps = {
		["g?"] = "actions.show_help",
		["<CR>"] = "actions.select",
		["<C-s>"] = "actions.select_split",
		["<C-v>"] = "actions.select_vsplit",
		["<C-t>"] = "actions.select_tab",
		["<Esc>"] = "actions.close",
		["<Tab>"] = "actions.preview",
		["<C-r>"] = "actions.refresh",
		["-"] = "actions.parent",
		["g."] = "actions.toggle_hidden",
	},
	view_options = {
		show_hidden = true
	}
})

vim.keymap.set("n", "<leader>o", function() oil.open() end, { desc = "Open parent directory" })

-- vim.api.nvim_create_user_command('Oil', function()
--         print(vim.fn.expand('%'))
--         require('oil').open_float(vim.fn.expand('%'))
--     end,
--     {}
-- )
