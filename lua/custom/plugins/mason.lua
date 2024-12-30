return {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason').setup({})
            require('mason-lspconfig').setup({
                ensure_installed = {
                    'rust_analyzer',
                    'lua_ls',
                },
                handlers = {
                    function(server_name)
                      require('lspconfig')[server_name].setup({})
                    end,
                }
            })
        end
    }
}
