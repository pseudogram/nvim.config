-- require("pseudogram.packer")
-- Package manager
-- require("pseudogram.lazy")

require("pseudogram.remap")
require("pseudogram.set")

local augroup = vim.api.nvim_create_augroup
local pseudogramGroup = augroup('pseudogram', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

-- a lua function that I also don't know how to use
--
-- function R(name)
--     require("plenary.reload").reload_module(name)
-- end
-- ]]

-- briefly highlight text when you yank
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})


-- when saving delete all trailing whitespace
autocmd({"BufWritePre"}, {
    group = pseudogramGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})



