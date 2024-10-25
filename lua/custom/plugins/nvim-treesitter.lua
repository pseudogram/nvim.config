return {
    'nvim-treesitter/nvim-treesitter',
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    lazy = false,
    config = function()
        require 'nvim-treesitter.configs'.setup {
            -- A list of parser names, or "all" (the five listed parsers should always be installed)
            ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "python",
                "css", "javascript", "typescript", "ruby", "html", "xml",
                "embedded_template" },
            -- autotag = {
            --     enable = true,
            -- },
            highlight = {
                enable = true
            }
        }
    end,
    dependencies = {
        'windwp/nvim-ts-autotag'
    },
}
