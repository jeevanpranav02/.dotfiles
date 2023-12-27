return {
	"akinsho/flutter-tools.nvim",
	ft = "dart",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"dart-lang/dart-vim-plugin",
		"nvim-lua/plenary.nvim",
		"RobertBrunhage/flutter-riverpod-snippets",
	},
	config = function()
		local local_lsp = require("jb.lsputils")
		-- Flutter Tools Setup
		require("flutter-tools").setup({
			debugger = {
				enabled = true,
				run_via_dap = true,
				register_configurations = function(_)
					require("dap.ext.vscode").load_launchjs()
				end,
				exception_breakpoints = {},
			},
			widget_guides = { enabled = true, debug = true },
			dev_log = {
				enabled = true,
				notify_errors = false,
				open_cmd = "tabedit",
			},
			lsp = {
				color = {
					enabled = true,
					background = true,
					background_color = {
						r = 19,
						g = 17,
						b = 24,
					}, -- required, when background is transparent (i.e. background_color = { r = 19, g = 17, b = 24},)
					virtual_text = true, -- show the highlight using virtual text
					virtual_text_str = "■", -- the virtual text character to highlight
				},
				settings = {
					showTodos = true,
					analysisExcludedFolders = {
						vim.fn.expand("$HOME") .. "/.pub-cache",
						vim.fn.expand("$HOME") .. "/.dartServer",
						vim.fn.expand("$HOME") .. "/tools/flutter",
					},
					renameFilesWithClasses = "always",
					enableSnippets = true,
					debugExternalPackageLibraries = false,
					debugSdkLibraries = false,
				},
				on_attach = function(client, bufnr)
					local_lsp.on_attach(client, bufnr)
					vim.keymap.set(
						"n",
						"<leader>fo",
						":FlutterOutlineToggle<CR>",
						{ desc = "flutter: outline", buffer = bufnr }
					)
					vim.keymap.set(
						"n",
						"<leader>fd",
						"<Cmd>FlutterDevices<CR>",
						{ desc = "flutter: devices", buffer = bufnr }
					)
					vim.keymap.set(
						"n",
						"<leader>fe",
						"<Cmd>FlutterEmulators<CR>",
						{ desc = "flutter: emulators", buffer = bufnr }
					)
					vim.keymap.set(
						"n",
						"<leader>fq",
						"<Cmd>FlutterQuit<CR>",
						{ desc = "flutter: quit", buffer = bufnr }
					)
					vim.keymap.set(
						"n",
						"<leader>fr",
						"<Cmd>FlutterRun<CR>",
						{ desc = "flutter: server run", buffer = bufnr }
					)
					vim.keymap.set(
						"n",
						"<leader>frs",
						"<Cmd>FlutterRestart<CR>",
						{ desc = "flutter: server restart", buffer = bufnr }
					)
					vim.keymap.set(
						"n",
						"<leader>frn",
						"<Cmd>FlutterRename<CR>",
						{ desc = "flutter: rename class (& file)", buffer = bufnr }
					)
					vim.keymap.set(
						"n",
						"<leader>fv",
						"<Cmd>FlutterVisualDebug<CR>",
						{ desc = "flutter: visual debug", buffer = bufnr }
					)
					vim.keymap.set(
						"n",
						"<leader>fdb",
						"<Cmd>TermExec direction='vertical' cmd='dart pub run build_runner watch'<CR>",
						{
							desc = "flutter: run code generation",
							buffer = 0,
						}
					)
				end,
				capabilities = local_lsp.capabilities,
			},
		})
		require("telescope").load_extension("flutter")
	end,
}
