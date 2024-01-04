local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

local on_attach = require("jb.lsputils").on_attach

local capabilities = require("jb.lsputils").capabilities
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
		return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname) or vim.fn.expand("%:p:h")
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
