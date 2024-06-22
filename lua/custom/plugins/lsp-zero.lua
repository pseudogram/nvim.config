-- Easy LSP Configuration
return {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    init = function()
        -- Disable automatic setup, we are doing it manually
        vim.g.lsp_zero_extend_cmp = 0
        vim.g.lsp_zero_extend_lspconfig = 0
    end,
    config = function()
        local lsp_zero = require("lsp-zero")
        local lspconfig = require('lspconfig')
        lspconfig.intelephense.setup({})

        -- lsp_zero.on_attach(function(client, bufnr)
        --     -- see :help lsp-zero-keybindings
        --     -- to learn the available actions
        --     lsp_zero.default_keymaps({ buffer = bufnr })
        -- end)


        lsp_zero.set_sign_icons({
            error = 'E',
            warn = 'W',
            hint = 'H',
            info = 'I'
        })
    end
}
