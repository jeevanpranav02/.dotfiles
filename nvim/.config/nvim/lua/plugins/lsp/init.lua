require("plugins.lsp.cmp")
require("plugins.lsp.mason")
local lsp = require("lsp-zero")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

lsp.preset("recommended")

local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "<leader>0", function()
		if vim.lsp.inlay_hint.is_enabled(bufnr) then
			vim.lsp.inlay_hint.enable(bufnr, false)
		else
			vim.lsp.inlay_hint.enable(bufnr, true)
		end
	end, opts)

	vim.keymap.set("n", "<leader>gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end

lsp.on_attach(on_attach)

lsp.setup()

-- TODO: I think I can remove this now.
local sign = function(opts)
	vim.fn.sign_define(opts.name, {
		texthl = opts.name,
		text = opts.text,
		numhl = "",
	})
end
sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = "⚠" })
sign({ name = "DiagnosticSignHint", text = "󰌶" })
sign({ name = "DiagnosticSignInfo", text = "󰋼" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(_, _, args) end,
})

vim.diagnostic.config({
	virtual_text = {
		source = "if_many",
		prefix = "●",
	},
	underline = true,
	signs = true,
	update_in_insert = true,
	severity_sort = true,
	float = {
		-- border = "single",
		source = "always",
	},
})

local lspconfig = require("lspconfig")
local lspconfig_util = require("lspconfig.util")

-- Rust Analyzer Setup
lspconfig.rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "rust" },
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
				autoReload = true,
			},
		},
	},
})

-- Lua Setup
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			codeLens = { enable = true },
			hint = { enable = true, arrayIndex = "Literal", setType = false, paramName = "Disable", paramType = true },
			format = { enable = false },
			diagnostics = {
				globals = { "vim", "P", "describe", "it", "before_each", "after_each", "packer_plugins", "pending" },
			},
			completion = { keywordSnippet = "Replace", callSnippet = "Replace" },
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
})

-- Php and Laravel Setup
lspconfig.intelephense.setup({
	commands = {
		IntelephenseIndex = {
			function()
				vim.lsp.buf.execute_command({ command = "intelephense.index.workspace" })
			end,
		},
	},
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.phpactor.setup({
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		client.server_capabilities.completionProvider = false
		client.server_capabilities.hoverProvider = false
		client.server_capabilities.implementationProvider = false
		client.server_capabilities.referencesProvider = false
		client.server_capabilities.renameProvider = false
		client.server_capabilities.selectionRangeProvider = false
		client.server_capabilities.signatureHelpProvider = false
		client.server_capabilities.typeDefinitionProvider = false
		client.server_capabilities.workspaceSymbolProvider = false
		client.server_capabilities.definitionProvider = false
		client.server_capabilities.documentHighlightProvider = false
		client.server_capabilities.documentSymbolProvider = false
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
	init_options = {
		["language_server_phpstan.enabled"] = false,
		["language_server_psalm.enabled"] = false,
	},
	handlers = {
		["textDocument/publishDiagnostics"] = function() end,
	},
})

-- JavaScript, TypeScript
lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	disable_formatting = true,
	settings = {
		javascript = {
			inlayHints = {
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
		typescript = {
			inlayHints = {
				includeInlayEnumMemberValueHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayVariableTypeHints = true,
			},
		},
	},
})

-- Tailwind CSS
lspconfig.tailwindcss.setup({ capabilities = capabilities })

-- JSON
lspconfig.jsonls.setup({
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
		},
	},
})

-- YAML
lspconfig.yamlls.setup {
  settings = {
    yaml = {
      schemaStore = {
        -- You must disable built-in schemaStore support if you want to use
        -- this plugin and its advanced options like `ignore`.
        enable = false,
        -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
        url = "",
      },
      schemas = require('schemastore').yaml.schemas(),
    },
  },
}

-- Python Setup
-- lspconfig.pyright.setup({
-- 	capabilities = capabilities,
-- 	root_dir = lspconfig_util.root_pattern(
-- 		"pyproject.toml",
-- 		".git",
-- 		"setup.py",
-- 		"setup.cfg",
-- 		"requirements.txt",
-- 		"Pipfile",
-- 		"pyrightconfig.json",
-- 		-- customize
-- 		"manage.py",
-- 		"server.py",
-- 		"main.py"
-- 	),
-- 	on_attach = on_attach,
-- 	settings = {
-- 		python = {
-- 			analysis = {
-- 				autoImportCompletions = true,
--
-- 				-- Determines whether pyright automatically adds common search paths like "src" if there are no execution environments defined in the config file.
-- 				autoSearchPaths = false,
--
-- 				--[[
--                     Determines whether pyright analyzes (and reports errors for) all files in the workspace, as indicated by the config file.
--                     If this option is set to "openFilesOnly", pyright analyzes only open files.
--                     ]]
-- 				diagnosticMode = "workspace", -- "openFilesOnly" | "workspace"
--
-- 				-- Paths to add to the default execution environment extra paths if there are no execution environments defined in the config file.
-- 				extraPaths = {},
--
-- 				-- Level of logging for Output panel. The default value for this option is "Information".
-- 				logLevel = "Information", -- "Error", "Warning", "Information", "Trace"
--
-- 				-- Path to directory containing custom type stub files.
-- 				-- stubPath = "",
--
-- 				-- Determines the default type-checking level used by pyright. This can be overridden in the configuration file.
-- 				typeCheckingMode = "basic", -- "off" | "basic" | "strict"
--
-- 				-- Paths to look for typeshed modules. Pyright currently honors only the first path in the array.
-- 				typeshedPaths = {},
--
-- 				--[[
--                     REFERENCE: https://github.com/microsoft/pyright/issues/3201#issuecomment-1069658359
--                     Determines whether pyright reads, parses and analyzes library code to extract type information in the absence of type stub files.
--                     Type information will typically be incomplete.
--                     We recommend using type stubs where possible. The default value for this option is false.
--                     ]]
-- 				useLibraryCodeForTypes = true,
-- 			},
-- 		},
-- 		pyright = {
-- 			--[[
--                 Disables all language services except for “hover”.
--                 This includes type completion, signature completion, find definition, find references, and find symbols in file.
--                 This option is useful if you want to use pyright only as a type checker but want to run another Python language server for language service features.
--                 ]]
-- 			disableLanguageServices = false,
--
-- 			--[[
--                 Disables the “Organize Imports” command.
--                 This is useful if you are using another extension that provides similar functionality and you don’t want the two extensions to fight each other.
--                 Accessible in Neovim with :PyrightOrganizeImports
--                 ]]
-- 			disableOrganizeImports = true,
-- 		},
-- 	},
-- })
local venv_path = os.getenv("VIRTUAL_ENV")
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
	py_path = venv_path .. "/bin/python3"
else
	py_path = vim.g.python3_host_prog
end
lspconfig.pylsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = function(fname)
		local root_files = {
			"pyproject.toml",
			"setup.py",
			"setup.cfg",
			"requirements.txt",
			"Pipfile",
		}
		return lspconfig_util.root_pattern(unpack(root_files))(fname)
			or lspconfig_util.find_git_ancestor(fname)
			or vim.fn.expand("%:p:h")
	end,

	settings = {
		-- https://github.com/python-lsp/python-lsp-server
		pylsp = {
			plugins = {
				autopep8 = { enabled = false },
				flake8 = {
					enabled = true,
					maxLineLength = 88,
					ignore = {
						"E501", -- Line too long
						"E203", -- Whitespace before ':'
						"E231", -- Missing whitespace after ','
						"E266", -- Too many leading '#' for block comment
						"E402", -- Module level import not at top of file
						"E722", -- Do not use bare 'except'
						"E741", -- Do not use variables named 'I', 'O', or 'l'
						"E743", -- Ambiguous function definition 'f'
						"E999", -- SyntaxError or IndentationError
						"W503", -- Line break occurred before a binary operator
						"W504", -- Line break occurred after a binary operator
						"W605", -- Invalid escape sequence '\ '
					},
					exclude = {
						"*/migrations/*",
						"*/manage.py",
						"*/settings.py",
						"*/settings/*",
						"*/urls.py",
						"*/wsgi.py",
						"*/__init__.py",
						"*/__pycache__/*",
						"*/tests/*",
						"*/tests.py",
						"*/test.py",
						"*/conftest.py",
						"*/conftest/*",
						"*/conftest/*",
						"*/conftest/*",
					},
				},
				mccabe = { enabled = false },
				pycodestyle = { enabled = false },
				pydocstyle = {
					enabled = false,
					convention = "numpy",
				},
				pyflakes = { enabled = false },
				pylint = {
					enabled = false,
					executable = "pylint",
				},
				rope_autoimport = {
					enabled = true,
					memory = false,
				},
				rope_completion = {
					enabled = false,
					eager = false,
				},
				yapf = { enabled = false },

				jedi = {
					environment = vim.env.VIRTUAL_ENV or "/usr",
				},
				jedi_completion = {
					enabled = true,
					fuzzy = true,
					eager = false,
					resolve_at_most = 25,
					cache_for = { "numpy", "pandas", "torch", "matplotlib" },
				},
				jedi_definition = {
					enabled = true,
					follow_builtin_imports = true,
					follow_imports = true,
				},
				jedi_hover = {
					enabled = true,
				},
				jedi_references = {
					enabled = true,
				},
				jedi_signature_help = {
					enabled = true,
				},
				jedi_symbols = {
					enabled = true,
					all_scopes = true,
					include_import_symbols = true,
				},

				-- Third Party Plugins
				-- Need to install in Mason pylsp venv
				-- source ~/.local/share/nvim/mason/packages/python-lsp-server/venv/bin/activate
				-- pip install pylsp-mypy pyls-isort python-lsp-black pylsp-rope python-lsp-ruff
				pylsp_mypy = {
					enabled = true,
					overrides = { "--python-executable", py_path, true },
					live_mode = true,
					report_progress = true,
					strict = false,
				},
				pyls_isort = {
					enabled = false,
				},
				black = {
					enabled = false,
					preview = true,
					line_length = 88,
				},
				pylsp_rope = {
					enabled = true,
				},
				ruff = {
					enabled = false,
				},
			},
		},
	},
	flags = {
		debounce_text_changes = 200,
	},
})

local M = {}
M.capabilities = capabilities
M.on_attach = on_attach
return M
