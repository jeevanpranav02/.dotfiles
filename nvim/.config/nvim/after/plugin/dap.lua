-- Debug Adapter Protocol (DAB)
local dap = require('dap')

-- ===============================================================================
-- For Dart and Flutter Support
dap.adapters.dart = {
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/mason/bin/dart-debug-adapter',
    args = { 'dart' }
}
dap.adapters.flutter = {
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/mason/bin/dart-debug-adapter',
    args = { 'flutter' },
    options = {
        detached = false,
    }
}
dap.configurations.dart = {
    {
        type = "dart",
        request = "launch",
        name = "Launch dart",
        dartSdkPath = "~/tools/flutter/bin/cache/dart-sdk/", -- ensure this is correct
        flutterSdkPath = "~/tools/flutter",                  -- ensure this is correct
        program = "${workspaceFolder}/lib/main.dart",        -- ensure this is correct
        cwd = "${workspaceFolder}",
    },
    {
        type = "flutter",
        request = "launch",
        name = "Launch flutter",
        dartSdkPath = "~/tools/flutter/bin/cache/dart-sdk/", -- ensure this is correct
        flutterSdkPath = "~/tools/flutter",                  -- ensure this is correct
        program = "${workspaceFolder}/lib/main.dart",        -- ensure this is correct
        cwd = "${workspaceFolder}",
    }
}
dap.defaults.dart.exception_breakpoints = { "Notice", "Warning", "Error", "Exception" }

-- =================================================================================

-- UI for DAP

local dapui = require('dapui')
dap.listeners.after['event_initialized']["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before['event_terminated']["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before['event_exited']["dapui_config"] = function()
    dapui.close()
end
dapui.setup({
    windows = { indent = 2 },
    layouts = {
        {
            elements = {
                { id = 'scopes',      size = 0.25 },
                { id = 'breakpoints', size = 0.25 },
                { id = 'stacks',      size = 0.25 },
                { id = 'watches',     size = 0.25 },
            },
            position = 'left',
            size = 20,
        },
        { elements = { { id = 'repl', size = 0.9 } }, position = 'bottom', size = 10 },
    },
}
)


-- =================================================================================
-- Virtual Text
require("nvim-dap-virtual-text").setup {
    enabled = true,

    -- DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, DapVirtualTextForceRefresh
    enabled_commands = false,

    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_changed_variables = true,
    highlight_new_as_changed = true,

    -- prefix virtual text with comment string
    commented = false,

    show_stop_reason = true,

    -- experimental features:
    virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = true,     -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
}



-- =================================================================================
-- Key Mappings
local function nnoremap(rhs, lhs, desc)
    local bufopts = { noremap = true, silent = true }
    bufopts.desc = desc
    vim.keymap.set("n", rhs, lhs, bufopts)
end


-- nvim-dap
nnoremap("<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Set breakpoint")
nnoremap("<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
    "Set conditional breakpoint")
nnoremap("<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
    "Set log point")
nnoremap('<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear breakpoints")
nnoremap('<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', "List breakpoints")

nnoremap("<leader>dc", "<cmd>lua require'dap'.continue()<cr>", "Continue")
nnoremap("<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", "Step over")
nnoremap("<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", "Step into")
nnoremap("<leader>do", "<cmd>lua require'dap'.step_out()<cr>", "Step out")
nnoremap('<leader>dd', "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect")
nnoremap('<leader>dt', "<cmd>lua require'dap'.terminate()<cr>", "Terminate")
nnoremap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", "Open REPL")
nnoremap("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", "Run last")
nnoremap('<leader>di', function() require "dap.ui.widgets".hover() end, "Variables")
nnoremap('<leader>d?', function()
    local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes)
end, "Scopes")
nnoremap('<leader>df', '<cmd>Telescope dap frames<cr>', "List frames")
nnoremap('<leader>dh', '<cmd>Telescope dap commands<cr>', "List commands")


-- Breakpoints on exceptions
vim.keymap.set("n", "<leader>da", function()
    require("dap").set_exception_breakpoints({ "Warning", "Error", "Exception" })
end, { desc = "Stop on exceptions" }) -- TODO this one doesn't show on which-key

vim.keymap.set("n", "<leader>dA", function()
    require("dap").set_exception_breakpoints({ "Notice", "Warning", "Error", "Exception" })
end, { desc = "Stop on all" })
