local lsp = require("lsp-zero")
local builtin = require('telescope.builtin')
local utils = require('pseudogram.utils')

lsp.preset("recommended")

lsp.ensure_installed({
    'tsserver',
    'rust_analyzer',
    'pylsp',
    'clangd',
    'lua_ls',
    'ruby_ls'
})

-- -- Fix Undefined global 'vim'
-- lsp.configure('lua-language-server', {
--     settings = {
--         Lua = {
--             diagnostics = {
--                 globals = { 'vim' }
--             }
--         }
--     }
-- })


local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = cmp.mapping.confirm({ select = true })
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
    mapping = cmp_mappings
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

function on_attach(opts)
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function()
        -- vim.lsp.buf.workspace_symbol()
        builtin.lsp_workspace_symbols()
    end, opts)
    vim.keymap.set("n", "<leader>pws", function()
        local word_under_cursor = vim.fn.expand("<cword>")
        builtin.lsp_workspace_symbols({query=word_under_cursor})
    end, opts)
    vim.keymap.set("v", "<leader>pws", function()
        local selection = utils.get_visual_selection()
        builtin.lsp_workspace_symbols({query=selection})
    end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    -- vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', "<leader>ca", "<cmd>Lspsaga code_action<cr>")
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    -- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("n", "<leader>vrn", "<cmd>Lspsaga rename<cr>")

    -- not sure what the following do
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
end

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    on_attach(opts)
end)

-- lsp.skip_server_setup({ 'tsserver' })

lsp.setup()

-- Setup with typescript.nvim -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/guides/quick-recipes.md#setup-with-typescriptnvim
-- require("typescript").setup({
--     disable_commands = false,         -- prevent the plugin from creating Vim commands
--     debug = false,                    -- enable debug logging for commands
--     go_to_source_definition = {
--         fallback = true,              -- fall back to standard LSP definition on failure
--     },
--     server = {                        -- pass options to lspconfig's setup method
--         on_attach = on_attach,
--     },
-- })


vim.diagnostic.config({
    virtual_text = true
})
