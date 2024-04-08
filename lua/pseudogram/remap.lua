vim.g.mapleader = " "

-- remap jj to escape
vim.keymap.set("i", "jj", "<Esc>")

-- project view
vim.keymap.set("n", "<leader>pv", vim.cmd.Explore) -- used to be Ex, but rails.vim broke it

-- In VISUAL mode move selected lines up (J) or down (K) one line at a time
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- cursor stays in place while line below are concatenated to the end of current
vim.keymap.set("n", "J", "mzJ`z")

-- keep cursor in place when using ctrl-d and ctrl-u to move up and down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search terms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever, delete current work and keep previous copy in p register
-- for pasting
vim.keymap.set("x", "<leader>p", [["_dP]])

-- greatest remap ever, delete current work and keep previous copy in p register
-- for pasting
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- delete without saving in register
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- aparently there is a difference when saving between C-c and Esc, so lets avoid
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Just don't use capital Q
vim.keymap.set("n", "Q", "<nop>")

-- use sessionizer in vim, god thats nice
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<C-s>", "<cmd>silent !tmux neww tmux-session-finder<CR>")

-- quick formatting using lsp
-- vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
vim.keymap.set("n", "<leader>f", ":Format<CR>")
vim.keymap.set("n", "<leader>F", ":FormatWrite<CR>")

-- move through the quickfix menu. TBD when working on c
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- replace a word in your active buffer
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Quick command to make the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- go to packer config
-- vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.config/nvim/lua/pseudogram/packer.lua<CR>");

-- run packer file extension
-- vim.keymap.set("n", "<leader>vpx", "<cmd>so ~/.config/nvim/lua/pseudogram/packer.lua<CR>");

-- vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- open vim diagnostic window for error under cursor
vim.keymap.set('n', "<leader>e", function() vim.diagnostic.open_float() end)

-- toggle virtual text
-- vim.keymap.set('n', "<leader>te", function() vim.diagnostic.set({virtual_text=!vim.diagnostic.config().virtual_text}) end)

-- go back to normal mode from terminal mode
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
vim.keymap.set("t", "jj", "<C-\\><C-n>")
