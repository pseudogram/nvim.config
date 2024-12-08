-- LSP
return {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
        -- For useful docs on how to configure LSPs use
        -- https://lsp-zero.netlify.app/docs/getting-started.html
        -- This is where all the LSP shenanigans will live
        local lspconfig = require('lspconfig')
        local builtin = require('telescope.builtin')
        local utils = require('pseudogram.utils')


        -- Add cmp_nvim_lsp capabilities settings to lspconfig
        -- This should be executed before you configure any language server
        local lspconfig_defaults = require('lspconfig').util.default_config
        lspconfig_defaults.capabilities = vim.tbl_deep_extend(
            'force',
            lspconfig_defaults.capabilities,
            require('cmp_nvim_lsp').default_capabilities()
        )

        -- This is where you enable features that only work
        -- if there is a language server active in the file
        vim.api.nvim_create_autocmd('LspAttach', {
            desc = 'LSP actions',
            callback = function(event)
                -- show two lines for the status so gitgutter and errors don't
                -- overlap
                -- vim.opt.signcolumn = 'yes:2'
                local opts = { buffer = event.buf }

                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
                vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
                vim.keymap.set('n', 'go', function() vim.lsp.buf.type_definition() end, opts)
                vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
                vim.keymap.set('n', 'gs', function() vim.lsp.buf.signature_help() end, opts)
                -- vim.keymap.set('n', '<F2>', function() vim.lsp.buf.rename() end, opts)
                -- vim.keymap.set({'n', 'x'}, '<F3>', function() vim.lsp.buf.format({async = true}) end, opts)
                -- vim.keymap.set('n', '<F4>', function() vim.lsp.buf.code_action() end, opts)

                vim.keymap.set("n", "<leader>vws", function()
                    -- vim.lsp.buf.workspace_symbol()
                    builtin.lsp_workspace_symbols()
                end, opts)
                vim.keymap.set("n", "<leader>pws", function()
                    local word_under_cursor = vim.fn.expand("<cword>")
                    builtin.lsp_workspace_symbols({ query = word_under_cursor })
                end, opts)
                vim.keymap.set("v", "<leader>pws", function()
                    local selection = utils.get_visual_selection()
                    builtin.lsp_workspace_symbols({ query = selection })
                end, opts)
                vim.keymap.set({ "i", "n" }, "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)

                -- not sure what the following do
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
            end,
        })

        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.HINT] = 'H',  -- '⚑',
                    [vim.diagnostic.severity.INFO] = 'I',  -- '»',
                    [vim.diagnostic.severity.WARN] = 'W',  -- '▲',
                    [vim.diagnostic.severity.ERROR] = 'E', --''✘',
                },
            },
            virtual_text = {
                severity = {
                    min = vim.diagnostic.severity.INFO
                }
            }
        })

        lspconfig.clangd.setup({})
    end
}
