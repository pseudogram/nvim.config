return {
    'mfussenegger/nvim-lint',
    config = function()
        local lint = require("lint")
        lint.linters.cspell = require("lint.util").wrap(lint.linters.cspell, function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT

            return diagnostic
        end)
        lint.linters.codespell = require("lint.util").wrap(lint.linters.codespell, function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT

            return diagnostic
        end)

        vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, { -- InsertLeave would be good
            callback = function()
                -- -- try_lint without arguments runs the linters defined in `linters_by_ft`
                -- -- for the current filetype
                -- require("lint").try_lint()

                local dont_lint = {'netrw'}
                for i=1, #dont_lint do
                    if vim.bo.ft == dont_lint[i] then
                        return
                    end
                end
                -- You can call `try_lint` with a linter name or a list of names to always
                -- run specific linters, independent of the `linters_by_ft` configuration
                lint.try_lint("cspell")
                lint.try_lint("codespell")
            end,
        })
    end
}
