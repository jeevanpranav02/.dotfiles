-- Debug Adapter Protocol (DAB)
local dap = require("dap")

-- Call this function when running debug adapter
function SetUpDapExceptionBreakPoints()
	require("dap").set_exception_breakpoints({ "raised", "uncaught", "userUnhandled" })
	print("DAP Exception Breakpoints Set")
end

vim.cmd([[
    augroup file_blade_php
      autocmd BufRead dap-repl lua SetUpDapExceptionBreakPoints()
    augroup END
]])
-- ===============================================================================
-- For Dart and Flutter Support
dap.adapters.dart = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
	args = { "dart" },
	options = {
		detached = false,
	},
}
dap.adapters.flutter = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
	args = { "flutter" },
	options = {
		detached = false,
	},
}
dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch dart",
		dartSdkPath = "~/tools/flutter/bin/cache/dart-sdk/", -- ensure this is correct
		flutterSdkPath = "~/tools/flutter", -- ensure this is correct
		program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
		cwd = "${workspaceFolder}",
	},
	{
		type = "flutter",
		request = "launch",
		name = "Launch flutter",
		dartSdkPath = "~/tools/flutter/bin/cache/dart-sdk/", -- ensure this is correct
		flutterSdkPath = "~/tools/flutter", -- ensure this is correct
		program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
		cwd = "${workspaceFolder}",
	},
}

-- =================================================================================
-- For Python Support

dap.adapters.python = function(cb, config)
	if config.request == "attach" then
		---@diagnostic disable-next-line: undefined-field
		local port = (config.connect or config).port
		---@diagnostic disable-next-line: undefined-field
		local host = (config.connect or config).host or "127.0.0.1"
		cb({
			type = "server",
			port = assert(port, "`connect.port` is required for a python `attach` configuration"),
			host = host,
			options = {
				source_filetype = "python",
			},
		})
	else
		cb({
			type = "executable",
			command = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python",
			args = { "-m", "debugpy.adapter" },
			options = {
				source_filetype = "python",
			},
		})
	end
end
dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		pythonPath = function()
			-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
			-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
			-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
			local cwd = vim.fn.getcwd()
			if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
				return cwd .. "/venv/bin/python"
			elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
				return cwd .. "/.venv/bin/python"
			else
				return "/usr/bin/python"
			end
		end,
	},
	{
		type = "python",
		request = "launch",
		name = "Launch Django",
		program = vim.fn.getcwd() .. "/manage.py",
		pythonPath = "python3",
		justMyCode = false,
		args = {
			"runserver",
			"127.0.0.1:8000",
			"--noreload",
		},
	},
	{
		type = "python",
		request = "launch",
		name = "Launch Flask",
		env = {
			FLASK_APP = vim.fn.getcwd() .. "/app.py",
			FLASK_DEBUG = "1",
		},
		program = vim.fn.getcwd() .. "/app.py",
		pythonPath = vim.fn.getcwd() .. "/.venv/bin/python",
		justMyCode = false,
		args = {
			"run",
			"--no-debugger",
			"--no-reload",
		},
	},
}

-- =================================================================================

-- UI for DAP

local dapui = require("dapui")
dap.listeners.after["event_initialized"]["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before["event_terminated"]["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before["event_exited"]["dapui_config"] = function()
	dapui.close()
end
dapui.setup({
	windows = { indent = 2 },
	layouts = {
		{
			elements = {
				{ id = "scopes", size = 0.25 },
				{ id = "breakpoints", size = 0.25 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 0.25 },
			},
			position = "left",
			size = 20,
		},
		{ elements = { { id = "repl", size = 0.9 } }, position = "bottom", size = 10 },
	},
})

-- =================================================================================
-- Virtual Text
require("nvim-dap-virtual-text").setup({
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
	all_frames = true, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
})

-- =================================================================================
-- Key Mappings
local function nnoremap(rhs, lhs, desc)
	local bufopts = { noremap = true, silent = true }
	bufopts.desc = desc
	vim.keymap.set("n", rhs, lhs, bufopts)
end

-- nvim-dap
nnoremap("<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Set breakpoint")
nnoremap(
	"<leader>bc",
	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
	"Set conditional breakpoint"
)
nnoremap(
	"<leader>bl",
	"<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>",
	"Set log point"
)
nnoremap("<leader>br", "<cmd>lua require'dap'.clear_breakpoints()<cr>", "Clear breakpoints")
nnoremap("<leader>ba", "<cmd>Telescope dap list_breakpoints<cr>", "List breakpoints")

nnoremap("<leader>dc", "<cmd>lua require'dap'.continue()<cr>", "Continue")
nnoremap("<F9>", "<cmd>lua require'dap'.step_over()<cr>", "Step over")
nnoremap("<F10>", "<cmd>lua require'dap'.step_into()<cr>", "Step into")
nnoremap("<F11>", "<cmd>lua require'dap'.step_out()<cr>", "Step out")
nnoremap("<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect")
nnoremap("<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", "Terminate")
nnoremap("<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", "Open REPL")
nnoremap("<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", "Run last")
nnoremap("<leader>di", function()
	require("dap.ui.widgets").hover()
end, "Variables")
nnoremap("<leader>d?", function()
	local widgets = require("dap.ui.widgets")
	widgets.centered_float(widgets.scopes)
end, "Scopes")
nnoremap("<leader>df", "<cmd>Telescope dap frames<cr>", "List frames")
nnoremap("<leader>dh", "<cmd>Telescope dap commands<cr>", "List commands")

-- Breakpoints on exceptions
vim.keymap.set("n", "<leader>da", function()
	require("dap").set_exception_breakpoints({ "Warning", "Error", "Exception" })
end, { desc = "Stop on exceptions" }) -- TODO this one doesn't show on which-key

vim.keymap.set("n", "<leader>dA", function()
	require("dap").set_exception_breakpoints({ "Notice", "Warning", "Error", "Exception" })
end, { desc = "Stop on all" })
