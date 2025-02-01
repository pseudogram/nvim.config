return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    config = function()
        local nt = require("neo-tree")
        local nt_command = require('neo-tree.command')

        nt.setup({
            close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
            filesystem = {
                follow_current_file = {
                    enabled = false,         -- This will find and focus the file in the active buffer every time
                    --               -- the current file is changed while the tree is open.
                    leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                },
                hijack_netrw_behavior = "open_current",
                -- "open_default", -- netrw disabled, opening a directory opens neo-tree
                -- in whatever position is specified in window.position
                -- "open_current",  -- netrw disabled, opening a directory opens within the
                -- window like netrw would, regardless of window.position
                -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                use_libuv_file_watcher = true,
            }
        })

        vim.keymap.set("n", "\\", "<cmd>Neotree toggle reveal<cr>",
            { silent = true, noremap = true }
        )
    end
}
