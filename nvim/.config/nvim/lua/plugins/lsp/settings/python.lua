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
					maxLineLength = 100,
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
					enabled = true,
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
