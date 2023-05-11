--[[ ~/.config/nvim/init.lua ]]
local M = {}

function M.checkPath(pathSubstring)
    local cwd = vim.fn.getcwd(-1, -1)

    return cwd:find(pathSubstring,1,true)
end

return M
