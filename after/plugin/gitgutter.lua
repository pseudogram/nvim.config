
-- highlight all git changes (G it + H ighlight)
vim.keymap.set('n', "<leader>gh", "<cmd>GitGutterLineHighlightsToggle<cr>")

-- staging and unstaging hunks from normal mode
vim.keymap.set('n', "ghs", "<cmd>GitGutterStageHunk<cr>")
vim.keymap.set('n', "ghu", "<cmd>GitGutterUndoHunk<cr>")
