local lazy = require("lazy")

plugins = {
    -- Search
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        version = '0.1.4',
          dependencies = { 'nvim-lua/plenary.nvim' }
    },

    -- Themes
    {
        'rose-pine/neovim',
        name = 'rose-pine',
        -- config = function()
        --     require('rose-pine').setup({
        --         variant = 'moon',
        --         disable_background = true,
        --     })
        --     vim.cmd('colorscheme rose-pine')
        -- end
    },

    -- treesiter builds an AST and improves highlighting
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },

    -- treesitter playground allows you to look at the AST
    {'nvim-treesitter/playground'},

    -- move between files fast
    {'ThePrimeagen/harpoon'},

    -- see your entire branching undo tree. literal magic
    {'mbbill/undotree'},

    -- Git on steroids
    {'tpope/vim-fugitive'},
    {'tpope/vim-commentary'},

    {'tpope/vim-rails'},

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            { 'williamboman/mason.nvim' }, -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },
    -- add closing brakets automatically
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },

    -- closing tags for xml like text
    {
        'windwp/nvim-ts-autotag',
        -- requires treesitter
    },

    {
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    {'pseudogram/jester'},
    {'williamboman/mason.nvim'},
    { 'mfussenegger/nvim-dap' },
    { 'jay-babu/mason-nvim-dap.nvim' },

    -- Nice errors
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    },

    { 'kkharji/lspsaga.nvim' },

    -- git gutter. enough said
    {'airblade/vim-gitgutter'},

    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        build = "make install_jsregexp"
    },

    -- edit directories and files in netrw like a normal buffer
    {
        'stevearc/oil.nvim',
        config = function()
            require('oil').setup({
                columns = {
                    "icon",
                    -- "permissions"
                },
                -- use_default_keymaps = false,
                default_file_explorer = false,
                -- keymaps = {
                --     ["g?"] = "actions.show_help",
                --     ["<CR>"] = "actions.select",
                --     ["<C-s>"] = "actions.select_split",
                --     ["<C-v>"] = "actions.select_vsplit",
                --     ["<C-t>"] = "actions.select_tab",
                --     ["<Esc>"] = "actions.close",
                --     ["<Tab>"] = "actions.preview",
                --     ["<C-r>"] = "actions.refresh",
                --     ["-"] = "actions.parent",
                --     ["g."] = "actions.toggle_hidden",
                -- },
                -- view_options = {
                --     show_hidden = true
                -- }
            })
        end
    },

}

opts = {}

lazy.setup(plugins, opts)

