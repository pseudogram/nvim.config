-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Find things as you need them
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}


	-- Theeemes
	use({
		'rose-pine/neovim',
		as = 'rose-pine',
		config = function()
			require('rose-pine').setup({
				variant = 'moon',
				disable_background = true,

			})
			vim.cmd('colorscheme rose-pine')
		end
	})

	-- treesiter builds an AST and improves highlighting
	use({ 'nvim-treesitter/nvim-treesitter', {run= ':TSUpdate'}})
	-- treesitter playground allows you to look at the AST
	use({ 'nvim-treesitter/playground'}) 
	
	-- move between files fast
	use({ 'ThePrimeagen/harpoon'})

	-- see your entire branching undo tree. literal magic
	use({ 'mbbill/undotree' })

	-- Git on steroids
	use({ 'tpope/vim-fugitive' })

	-- LSP
	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
			-- LSP Support
			{'neovim/nvim-lspconfig'},             -- Required
			{                                      -- Optional
			'williamboman/mason.nvim',
			run = function()
				pcall(vim.cmd, 'MasonUpdate')
			end,
		},
		{'williamboman/mason-lspconfig.nvim'}, -- Optional

		-- Autocompletion
		{'hrsh7th/nvim-cmp'},     -- Required
		{'hrsh7th/cmp-nvim-lsp'}, -- Required
		{'L3MON4D3/LuaSnip'},     -- Required
	}
}
end)
