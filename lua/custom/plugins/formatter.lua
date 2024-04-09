return {
    'mhartington/formatter.nvim',
    config = function()
        -- Utilities for creating configurations
        local util = require "formatter.util"


        -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
        require("formatter").setup {
            -- Enable or disable logging
            -- logging = true,
            -- Set the log level
            -- log_level = vim.log.levels.WARN,
            -- All formatter configurations are opt-in
            filetype = {
                -- Formatter configurations for filetype "lua" go here
                -- and will be executed in order

                -- lua = {
                --     -- "formatter.filetypes.lua" defines default configurations for the
                --     -- "lua" filetype
                --     require("formatter.filetypes.lua").stylua,

                --     -- You can also define your own configuration
                --     function()
                --         -- Supports conditional formatting
                --         if util.get_current_buffer_file_name() == "special.lua" then
                --             return nil
                --         end

                --         -- Full specification of configurations is down below and in Vim help
                --         -- files
                --         return {
                --             exe = "stylua",
                --             args = {
                --                 "--search-parent-directories",
                --                 "--stdin-filepath",
                --                 util.escape_path(util.get_current_buffer_file_path()),
                --                 "--",
                --                 "-",
                --             },
                --             stdin = true,
                --         }
                --     end
                -- },

                -- eruby = { require("formatter.filetypes.ruby").rubocop,
                --     require("formatter.defaults.prettier") },

                ruby = require("formatter.filetypes.ruby").rubocop,
                html = {
                    require("formatter.defaults.prettier"),
                },
                javascript = {
                    require("formatter.defaults.prettier"),
                },
                javascriptreact = {
                    require("formatter.defaults.prettier"),
                },
                typescript = {
                    require("formatter.defaults.prettier"),
                },
                typescriptreact = {
                    require("formatter.defaults.prettier"),
                },
                json = {
                    require("formatter.defaults.prettier"),
                },

                -- Use the special "*" filetype for defining formatter configurations on
                -- any filetype
                ["*"] = {
                    -- "formatter.filetypes.any" defines default configurations for any
                    -- filetype
                    require("formatter.filetypes.any").remove_trailing_whitespace,

                    -- lsp formatter
                    function()
                        local formatters = require("formatter.util").get_available_formatters_for_ft(vim.bo.filetype)
                        -- do nothing if other formatters exist
                        -- print(formatters)
                        if #formatters > 0 then
                            -- print('multi formaters')
                            return
                        end

                        -- check if there are any LSP formatters
                        local lsp_clients = vim.lsp.buf_get_clients()
                        for _, client in pairs(lsp_clients) do
                            -- format with the lsp
                            if client.server_capabilities.documentFormattingProvider then
                                vim.lsp.buf.format()
                                return
                            end
                        end
                        -- Optional: default to prettier
                        -- return prettier()
                    end,
                }
            }
        }
    end
};
