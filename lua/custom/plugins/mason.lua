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
                    'tsserver',
                    'rust_analyzer',
                    'pylsp',
                    'clangd',
                    'lua_ls',
                    'ruby_ls',
                    'solargraph'
                },
                handlers = {
                    lsp_zero.default_setup,
                }
            })
        end
    }
}
