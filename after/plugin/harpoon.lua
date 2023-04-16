local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

vim.keymap.set("n", "<C-h><C-h>", function() ui.nav_file(1) end)
vim.keymap.set("n", "<C-j><C-j>", function() ui.nav_file(2) end)
vim.keymap.set("n", "<C-k><C-k>", function() ui.nav_file(3) end)
vim.keymap.set("n", "<C-l><C-l>", function() ui.nav_file(4) end)

