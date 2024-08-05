return {
    'mfussenegger/nvim-dap',
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "theHamsta/nvim-dap-virtual-text",
        "williamboman/mason.nvim"
    },
    config = function()
        local dap = require('dap')
        local dapui = require("dapui")
        -- local ui_config = {
        --     icons = { expanded = "🞃", collapsed = "🞂", current_frame = "→" },
        --     controls = {
        --         icons = {
        --             pause = "⏸",
        --             play = "⯈",
        --             step_into = "↴",
        --             step_over = "↷",
        --             step_out = "↑",
        --             step_back = "↶",
        --             run_last = "🗘",
        --             terminate = "🕱",
        --             disconnect = "⏻"
        --         }
        --     }
        -- }
        -- dapui.setup(ui_config)

        -- to use icons install font-hack-nerd-font (brew)
        dapui.setup()

        require("nvim-dap-virtual-text").setup()

        vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
        vim.keymap.set("n", "<leader>gb", dap.run_to_cursor)

        -- Eval under cursor
        vim.keymap.set("n", "<leader>?", function()
            dapui.eval(nil, { enter = true })
        end)

        vim.keymap.set("n", "<F1>", dap.continue)
        vim.keymap.set("n", "<F2>", dap.step_into)
        vim.keymap.set("n", "<F3>", dap.step_over)
        vim.keymap.set("n", "<F4>", dap.step_out)
        vim.keymap.set("n", "<F5>", dap.step_back)
        vim.keymap.set("n", "<F6>", dap.restart)

        -- dap ui stuff
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end


        -- Python
        dap.configurations.python = {
            {
                type = 'python',
                request = 'launch',
                name = "Launch file",
                program = "${file}",
                pythonPath = function()
                    return '/usr/bin/python'
                end,
            },
        }

        -- C++
        -- dap.adapters.gdb = {
        --     type = "executable",
        --     command = "gdb",
        --     args = { "-i", "dap" }
        -- }
        -- dap.configurations.cpp = {
        --     {
        --         name = "Launch",
        --         type = "gdb",
        --         request = "launch",
        --         program = function()
        --             return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        --         end,
        --         cwd = "${workspaceFolder}",
        --         stopAtBeginningOfMainSubprogram = false,
        --     },
        -- }

        -- C++ - lldb
        -- dap.adapters.lldb = {
        --     type = 'executable',
        --     command = '$HOME/.local/share/nvim/mason/bin/codelldb', -- adjust as needed, must be absolute path
        --     name = 'lldb'
        -- }
        dap.adapters.codelldb = {
            type = 'server',
            port = "${port}",
            executable = {
                -- CHANGE THIS to your path!
                command = os.getenv('HOME') .. '/.local/share/nvim/mason/bin/codelldb',
                args = { "--port", "${port}" },

                -- On windows you may have to uncomment this:
                -- detached = false,
            }
        }
        local lldb = {
            name = 'Launch file',
            type = 'codelldb',
            request = 'launch',
            program = function()
                return vim.fn.input(
                    'Path to executable: ',
                    vim.fn.getcwd() .. '/',
                    'file'
                )
            end,
            cwd = '${workspaceFolder}',
            stopOnEntry = false,
            -- args = {},
            runInTerminal = true,
            -- 💀
            -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
            --
            --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            --
            -- Otherwise you might get the following error:
            --
            --    Error on launch: Failed to attach to the target process
            --
            -- But you should be aware of the implications:
            -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
            -- runInTerminal = false,
        }
        if vim.loop.os_uname().sysname == 'Darwin' then
            -- gdb doesn't work on mac arm chips... yet
            dap.configurations.cpp = {
                lldb
            }
        else
            print(string.format(
                "We're %s os, and you've not configrued a cpp debugger",
                vim.loop.os_uname().sysname
            ))
        end
    end
}
