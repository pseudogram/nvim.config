-- local oil = require("oil")
-- Returns `cwd` or path of current buffer depending on whether the current window is terminal or nothing
local function current_path()
  local current_win_info = vim.fn["getwininfo"](vim.api.nvim_get_current_win())
  if current_win_info == nil or #current_win_info == 0 then
    return vim.fn["getcwd"]()
  end
  return vim.fn.expand("%:p:h")
end

vim.keymap.set("n", "<leader>o", function()
  if vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(0), "filetype") == "oil" then
    return require("oil").close()
  else
    return require("oil").open_float(current_path())
  end
end, { desc = "Toggle Oil filemanager" })
