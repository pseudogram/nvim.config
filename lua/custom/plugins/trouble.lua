return {
    "folke/trouble.nvim",
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, icons are false
    opts = {
        icons = false
    },
    config = function()
        vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
            { silent = true, noremap = true }
        )
        vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
            { silent = true, noremap = true }
        )
        vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
            { silent = true, noremap = true }
        )
        vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
            { silent = true, noremap = true }
        )
    end
}
