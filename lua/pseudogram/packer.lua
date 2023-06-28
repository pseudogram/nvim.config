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
        requires = { { 'nvim-lua/plenary.nvim' } }
    }


    -- Theeemes
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        -- config = function()
        --     require('rose-pine').setup({
        --         variant = 'moon',
        --         disable_background = true,
        --     })
        --     vim.cmd('colorscheme rose-pine')
        -- end
    })

    -- treesiter builds an AST and improves highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }


    -- treesitter playground allows you to look at the AST
    use({ 'nvim-treesitter/playground' })

    -- move between files fast
    use({ 'ThePrimeagen/harpoon' })

    -- see your entire branching undo tree. literal magic
    use({ 'mbbill/undotree' })

    -- Git on steroids
    use({ 'tpope/vim-fugitive' })
    use({ 'tpope/vim-commentary' })

    -- LSP
    use({
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    })
    -- add closing brakets automatically
    use({
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    })
    -- closing tags for xml like text
    use({
        'windwp/nvim-ts-autotag',
        -- requires treesitter
    })

    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- typescript plugin for nvim.lsp (config in lsp zero)
    use({
        "jose-elias-alvarez/typescript.nvim",
    })

    -- add typescript and other actions to lsp code actions
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" }
    })

    use({
        "jay-babu/mason-null-ls.nvim",
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = nil,
                automatic_installation = true,
            })
        end
    })

    use({ "pseudogram/jester" })
    use('williamboman/mason.nvim')
    use 'mfussenegger/nvim-dap'
    use 'jay-babu/mason-nvim-dap.nvim'

    -- Nice errors
    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    })

    use({ "kkharji/lspsaga.nvim" })
    --use({
    --    "nvimdev/lspsaga.nvim",
    --    opt = true,
    --    branch = "main",
    --    event = "LspAttach",
    --    config = function()
    --        require("lspsaga").setup({})
    --    end,
    --    requires = {
    --        --{"nvim-tree/nvim-web-devicons"},
    --        --Please make sure you install markdown and markdown_inline parser
    --        {"nvim-treesitter/nvim-treesitter"}
    --    }
    --})

    -- git gutter. enough said
    use({ "airblade/vim-gitgutter" })

    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v1.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })

    -- edit directories and files in netrw like a normal buffer
    use {
      'stevearc/oil.nvim',
    }
end)



