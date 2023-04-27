local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    -- ..., -- add to your other sources
    require("typescript.extensions.null-ls.code-actions"),
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.completion.spell,
  },
})
