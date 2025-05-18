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

    local excluded_filetype = {
      netrw = true,
      harpoon = true
    }
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = function()
        local ft = vim.bo.filetype
        if not excluded_filetype[ft] then
          lint.try_lint("cspell")
          lint.try_lint("codespell")
        end
      end,
    })
  end
}
