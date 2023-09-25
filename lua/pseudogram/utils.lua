--[[ ~/.config/nvim/init.lua ]]
local M = {}

function M.checkPath(pathSubstring)
    local cwd = vim.fn.getcwd(-1, -1)

    return cwd:find(pathSubstring,1,true)
end

function M.get_visual_selection()
    -- Yank current visual selection into the 'v' register
    --
    -- Note that this makes no effort to preserve this register
    vim.cmd('noau normal! "vy"')

    return vim.fn.getreg('v')
end

return M
