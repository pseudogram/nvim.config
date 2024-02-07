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
        lsp_zero.preset("recommended")

        lsp_zero.set_sign_icons({
            error = 'E',
            warn = 'W',
            hint = 'H',
            info = 'I'
        })
    end
}
