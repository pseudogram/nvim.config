vim.api.nvim_create_autocmd(
    { 'BufNewFile', 'BufRead' },
    {
        pattern = '*.thor',
        callback = function()
            vim.o.filetype = 'ruby'
        end
    }
)
