local utils = require('pseudogram.utils')

local options = {}

if utils.checkPath([[opendata-portal]]) then
    options = {
        cmd = "node ./scripts/runTestInCorrectProject.js '$file' -t '$result'", -- run command
        escapeRegex = false,
        identifiers = { "test", "it" },                                         -- used to identify tests
        prepend = { "describe" },                                               -- prepend describe blocks
        expressions = { "call_expression" },                                    -- tree-sitter object used to scan for tests/describe blocks
        -- path_to_jest_run = 'jest',                 -- used to run tests
        -- path_to_jest_debug = './node_modules/.bin/jest', -- used for debugging
        terminal_cmd = ":vsplit | terminal", -- used to spawn a terminal for running tests, for debugging refer to nvim-dap's config
        dap = {
            -- debug adapter configuration
            type = 'node2',
            request = 'launch',
            cwd = vim.fn.getcwd(),
            runtimeArgs = { '--inspect-brk', '$path_to_jest', '--no-coverage', '-t', '$result', '--', '$file' },
            args = { '--no-cache' },
            sourceMaps = false,
            protocol = 'inspector',
            skipFiles = { '<node_internals>/**/*.js' },
            console = 'integratedTerminal',
            port = 9229,
            disableOptimisticBPs = true
        }
    }
end

local jester = require("jester")

jester.setup(options)

-- test nearest test under cursor
vim.keymap.set("n", "<leader>tn", function() jester.run()  end)

-- test current file
vim.keymap.set("n", "<leader>tf", function() jester.run_file()  end)

-- test last tests
vim.keymap.set("n", "<leader>tl", function() jester.run_last()  end)

-- debug test nearest test under cursor
vim.keymap.set("n", "<leader>dtn", function() jester.debug()  end)

-- debug test current file
vim.keymap.set("n", "<leader>dtf", function() jester.debug_file()  end)

-- debug test last tests
vim.keymap.set("n", "<leader>dtl", function() jester.debug_last()  end)



-- local augroup = vim.api.nvim_create_augroup
-- local localProjectGroup = augroup('LocalProjects', {})

-- local autocmd = vim.api.nvim_create_autocmd

-- -- briefly highlight text when you yank
-- autocmd('TextYankPost', {
--     group = yank_group,
--     pattern = '*',
--     callback = function()
--         vim.highlight.on_yank({
--             higroup = 'IncSearch',
--             timeout = 40,
--         })
--     end,
-- })


-- -- when saving delete all trailing whitespace
-- autocmd({"BufWritePre"}, {
--     group = pseudogramGroup,
--     pattern = "*",
--     command = [[%s/\s\+$//e]],

-- })
