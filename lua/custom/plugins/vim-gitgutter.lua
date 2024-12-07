return {
    'airblade/vim-gitgutter',
    config = function()
        -- highlight all git changes (G it + H ighlight)
        vim.keymap.set('n', "<leader>gh", "<cmd>GitGutterLineHighlightsToggle<cr>")
        -- staging and unstaging hunks from normal mode
        vim.keymap.set('n', "ghs", "<cmd>GitGutterStageHunk<cr>")
        vim.keymap.set('n', "ghu", "<cmd>GitGutterUndoHunk<cr>")

        -- Show difference to origin for current file
        vim.keymap.set('n', "<leader>gd", "<cmd>GitGutterDiffOrig<cr>")
    end
}
