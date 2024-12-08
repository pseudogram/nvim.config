vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80,100,120,121,122,123,124,125,126,127,128,129,130"

-- open new files from netrw in same window (default)
vim.g.netrw_browse_split = 0

-- when opening a file in split mode from netrw, file take 75% of screen
vim.g.netrw_winsize = 75

-- hide netrw banner that gives usage info
vim.g.netrw_banner = 0

-- ignore case letters when searching
vim.opt.ignorecase = true
-- if searching with a cased letter, then care
vim.opt.smartcase = true

-- By default set the foldmethod for all filetypes, can be overwritten per
-- file using an ftplugin
vim.opt.foldmethod = 'indent'
-- recommendations say to use foldlevelstart but I found that didn't work
vim.opt.foldlevel=99
