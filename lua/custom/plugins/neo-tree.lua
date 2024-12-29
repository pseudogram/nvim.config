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
        })


        vim.keymap.set("n", "<leader>/", "<cmd>Neotree toggle reveal<cr>",
            { silent = true, noremap = true }
        )
        -- nnoremap / :Neotree toggle current reveal_force_cwd<cr>
        -- nnoremap | :Neotree reveal<cr>
        -- nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
        -- nnoremap <leader>b :Neotree toggle show buffers right<cr>
        -- nnoremap <leader>s :Neotree float git_status<cr>

        -- vim.keymap.set('n', '<leader>/', function()
        --   local reveal_file = vim.fn.expand('%:p')
        --   if (reveal_file == '') then
        --     reveal_file = vim.fn.getcwd()
        --   else
        --     local f = io.open(reveal_file, "r")
        --     if (f) then
        --       f.close(f)
        --     else
        --       reveal_file = vim.fn.getcwd()
        --     end
        --   end
        --   nt_command.execute({
        --     action = "focus",          -- OPTIONAL, this is the default value
        --     source = "filesystem",     -- OPTIONAL, this is the default value
        --     position = "left",         -- OPTIONAL, this is the default value
        --     reveal_file = reveal_file, -- path to file or folder to reveal
        --     reveal_force_cwd = true,   -- change cwd without asking if needed
        --   })
        --   end,
        --   { desc = "Open neo-tree at current file or working directory" }
        -- );
    end
}
