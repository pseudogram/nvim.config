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
        -- This is where all the LSP shenanigans will live
        local lsp_zero = require('lsp-zero')
        local builtin = require('telescope.builtin')
        local utils = require('pseudogram.utils')

        lsp_zero.extend_lspconfig()

        --- if you want to know more about lsp-zero and mason.nvim
        --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({ buffer = bufnr })
        end)

        require('mason-lspconfig').setup({
            ensure_installed = {},
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    -- (Optional) Configure lua language server for neovim
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            }
        })



        local function on_attach(opts)
            vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
            vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
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
            vim.keymap.set({"i","n"}, "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
            -- vim.keymap.set('n', "<leader>ca", "<cmd>Lspsaga code_action<cr>")
            vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
            -- vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set("n", "<leader>vrn", "<cmd>Lspsaga rename<cr>")

            -- not sure what the following do
            vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
            vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
            vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        end

        lsp_zero.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
            on_attach(opts)
        end)

        -- lsp.skip_server_setup({ 'tsserver' })

        -- lsp.setup()

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
    end
}
