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
                    enabled = false,
                    leave_dirs_open = false
                },
                hijack_netrw_behavior = "disabled",
                use_libuv_file_watcher = true,
            }
        })

       vim.keymap.set("n", "\\", "<cmd>Neotree toggle reveal<cr>",
            { silent = true, noremap = true }
        )
    end
}
