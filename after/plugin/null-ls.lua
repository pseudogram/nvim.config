local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
    sources = {
        -- require("typescript.extensions.null-ls.code-actions"),
        null_ls.builtins.diagnostics.cspell.with({
            diagnostic_config = {
                -- see :help vim.diagnostic.config()
                underline = true,
                virtual_text = false,
                signs = true,
                update_in_insert = false,
                severity_sort = true,
            },
            -- Force the severity to be HINT
            diagnostics_postprocess = function(diagnostic)
                diagnostic.severity = vim.diagnostic.severity.HINT
            end,
        }),
        null_ls.builtins.code_actions.cspell,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.code_actions.eslint,
        null_ls.builtins.formatting.prettierd
    },
    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.keymap.set("n", "<Leader>f", function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })

            -- -- format on save
            -- vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
            -- vim.api.nvim_create_autocmd(event, {
            --     buffer = bufnr,
            --     group = group,
            --     callback = function()
            --         vim.lsp.buf.format({ bufnr = bufnr, async = async })
            --     end,
            --     desc = "[lsp] format on save",
            -- })
        end

        -- format in visual mode
        if client.supports_method("textDocument/rangeFormatting") then
            vim.keymap.set("x", "<Leader>f", function()
                vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
            end, { buffer = bufnr, desc = "[lsp] format" })
        end
    end,
})
