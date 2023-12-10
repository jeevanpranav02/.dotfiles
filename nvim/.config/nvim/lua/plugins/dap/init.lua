-- Debug Adapter Protocol (DAB)
local dap = require("dap")
dap.set_log_level("TRACE")

-- Call this function when running debug adapter
-- function SetUpDapExceptionBreakPoints()
-- 	require("dap").set_exception_breakpoints({ "raised", "uncaught", "userUnhandled" })
-- 	print("DAP Exception Breakpoints Set")
-- end

-- vim.cmd([[
--     augroup file_blade_php
--       autocmd BufRead dap-repl lua SetUpDapExceptionBreakPoints()
--     augroup END
-- ]])

-- Load launch.json in Debug Adapter Protocol (DAP)
require("dap.ext.vscode").load_launchjs()

-- ===============================================================================
-- For Rust support
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "/home/jp/tools/codelldb/extension/adapter/codelldb",
		args = { "--port", "${port}" },
	},
}
dap.adapters.lldb = {
	type = "executable",
	command = "/usr/bin/lldb-vscode",
	name = "lldb",
}
local function program()
	return vim.fn.input({
		prompt = "Path to executable: ",
		default = vim.fn.getcwd() .. "/",
		completion = "file",
	})
end
local configs = {
	{
		name = "cppdbg: Launch",
		type = "cppdbg",
		request = "launch",
		program = program,
		cwd = "${workspaceFolder}",
		externalConsole = true,
		args = {},
	},
	{
		name = "cppdbg: Attach",
		type = "cppdbg",
		request = "Attach",
		processId = function()
			return tonumber(vim.fn.input({ prompt = "Pid: " }))
		end,
		program = program,
		cwd = "${workspaceFolder}",
		args = {},
	},
	{
		name = "codelldb: Launch",
		type = "codelldb",
		request = "launch",
		program = program,
		cwd = "${workspaceFolder}",
		args = {},
	},
	{
		name = "codelldb: Launch external",
		type = "codelldb",
		request = "launch",
		program = program,
		cwd = "${workspaceFolder}",
		args = {},
		terminal = "external",
	},
	{
		name = "codelldb: Attach (select process)",
		type = "codelldb",
		request = "attach",
		pid = require("dap.utils").pick_process,
		args = {},
	},
	{
		name = "codelldb: Attach (input pid)",
		type = "codelldb",
		request = "attach",
		pid = function()
			return tonumber(vim.fn.input({ prompt = "pid: " }))
		end,
		args = {},
	},
	{
		name = "lldb: Launch (integratedTerminal)",
		type = "lldb",
		request = "launch",
		program = program,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = true,
	},
	{
		name = "lldb: Launch (console)",
		type = "lldb",
		request = "launch",
		program = program,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = false,
	},
	{
		name = "lldb: Attach to process",
		type = "lldb",
		request = "attach",
		pid = require("dap.utils").pick_process,
		args = {},
	},
	setmetatable({
		name = "Neovim",
		type = "cppdbg",
		request = "launch",
		program = os.getenv("HOME") .. "/tools/neovim/neovim/build/bin/nvim",
		cwd = os.getenv("HOME") .. "/tools/neovim/neovim/",
		externalConsole = true,
		args = {
			"--clean",
			"--cmd",
			"call getchar()",
		},
	}, {
		__call = function(config)
			local key = "me.neovim"
			dap.listeners.after.initialize[key] = function(session)
				session.on_close[key] = function()
					for _, handler in pairs(dap.listeners.after) do
						handler["me.neovim"] = nil
					end
				end
			end
			dap.listeners.after.event_process[key] = function(_, body)
				dap.listeners.after.initialize[key] = nil
				local ppid = body.systemProcessId
				vim.wait(1000, function()
					return tonumber(vim.fn.system("ps -o pid= --ppid " .. tostring(ppid))) ~= nil
				end)
				local pid = tonumber(vim.fn.system("ps -o pid= --ppid " .. tostring(ppid)))
				if pid then
					dap.run({
						name = "Neovim embedded",
						type = "cppdbg",
						request = "attach",
						program = os.getenv("HOME") .. "/tools/neovim/neovim/build/bin/nvim",
						processId = pid,
						cwd = os.getenv("HOME") .. "/tools/neovim/neovim/",
						externalConsole = false,
					})
				end
			end
			return config
		end,
	}),
}

dap.configurations.c = configs
dap.configurations.rust = configs
dap.configurations.cpp = configs
-- ===============================================================================
-- For Dart and Flutter Support

dap.adapters.dart = {
	args = { "debug_adapter" },
	command = "dart",
	type = "executable",
	debugExternalPackageLibraries = false,
	debugSdkLibraries = false,
	showGettersInDebugViews = true,
}
dap.adapters.flutter = {
	args = { "debug_adapter" },
	command = "flutter",
	type = "executable",
	debugExternalPackageLibraries = false,
	debugSdkLibraries = false,
	showGettersInDebugViews = true,
}
dap.configurations.dart = {
	{
		type = "dart",
		request = "launch",
		name = "Launch dart",
		dartSdkPath = "/home/jp/tools/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
		flutterSdkPath = "/home/jp/tools/flutter/bin/flutter", -- ensure this is correct
		program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
		cwd = "${workspaceFolder}",
	},
	{
		type = "flutter",
		request = "launch",
		name = "Launch flutter",
		dartSdkPath = "/home/jp/tools/flutter/bin/cache/dart-sdk/bin/dart", -- ensure this is correct
		flutterSdkPath = "/home/jp/tools/flutter/bin/flutter", -- ensure this is correct
		program = "${workspaceFolder}/lib/main.dart", -- ensure this is correct
		cwd = "${workspaceFolder}",
		debugExternalPackageLibraries = false,
		debugSdkLibraries = false,
		sendLogsToClient = true,
		evaluateGettersInDebugViews = true,
		evaluateToStringInDebugViews = true,
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

-- local dapui = require("dapui")
-- dap.listeners.after["event_initialized"]["dapui_config"] = function()
-- 	dapui.open()
-- end
-- dap.listeners.before["event_terminated"]["dapui_config"] = function()
-- 	dapui.close()
-- end
-- dap.listeners.before["event_exited"]["dapui_config"] = function()
-- 	dapui.close()
-- end
-- dapui.setup({
-- 	windows = { indent = 2 },
-- 	layouts = {
-- 		{
-- 			elements = {
-- 				{ id = "scopes", size = 0.25 },
-- 				{ id = "breakpoints", size = 0.25 },
-- 				{ id = "stacks", size = 0.25 },
-- 				{ id = "watches", size = 0.25 },
-- 			},
-- 			position = "left",
-- 			size = 20,
-- 		},
-- 		{ elements = { { id = "repl", size = 0.9 } }, position = "bottom", size = 10 },
-- 	},
-- })

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
nnoremap("<leader>dq", "<cmd>lua require'dap'.terminate()<cr>", "Terminate")
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
	require("dap").set_exception_breakpoints()
end, { desc = "Stop on exceptions" }) -- TODO this one doesn't show on which-key

vim.keymap.set("n", "<leader>dA", function()
	require("dap").set_exception_breakpoints({ "Notice", "Warning", "Error", "Exception" })
end, { desc = "Stop on all" })
