-- Autocompletion
return {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
        { 'L3MON4D3/LuaSnip' },
    },
    config = function()
        local cmp = require('cmp')

        -- And you can configure cmp even more, if you want to.
        -- local cmp_action = lsp_zero.cmp_action()
        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            mapping = cmp.mapping.preset.insert({
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
                { name = 'luasnip' },  -- For luasnip users.
                -- { name = 'ultisnips' }, -- For ultisnips users.
                -- { name = 'snippy' }, -- For snippy users.
            }, {
                { name = 'buffer' },
            })
        })
    end
}
