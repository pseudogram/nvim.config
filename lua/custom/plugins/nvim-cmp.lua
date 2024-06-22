-- Autocompletion
return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        { 'L3MON4D3/LuaSnip' },
        { 'VonHeikemen/lsp-zero.nvim' } -- needed by config
    },
    config = function()
        local lsp_zero = require('lsp-zero')
        local cmp = require('cmp')

        -- defaults given by configs in lsp-zero
        -- Here is where you configure the autocompletion settings.
        lsp_zero.extend_cmp()

        -- And you can configure cmp even more, if you want to.
        -- local cmp_action = lsp_zero.cmp_action()
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            formatting = lsp_zero.cmp_format(),
            mapping = cmp.mapping.preset.insert({
                -- from lsp-zero docs config
                -- ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                -- ['<C-d>'] = cmp.mapping.scroll_docs(4),
                -- ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                -- ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                -- lsp.defaults.cmp_mappings
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),

                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ['<S-Tab>'] = nil,
            }),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            sources = cmp.config.sources({
                { name = 'nvim_lsp' }, -- For nvim LSP completions (lspzero)
                -- { name = 'vsnip' }, -- For vsnip users.
                { name = 'luasnip' }, -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }, {
                { name = 'buffer' },
            })
        })
    end
}
