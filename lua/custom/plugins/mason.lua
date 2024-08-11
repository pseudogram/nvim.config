return {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            local lsp_zero = require('lsp-zero')

            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'rust_analyzer',
                    'pylsp',
                    'lua_ls',
                },
                handlers = {
                    lsp_zero.default_setup,
                }
            })
        end
    }
}
