return {
	{
		"VonHeikemen/lsp-zero.nvim",
		lazy = true,
		event = { "BufReadPre", "BufNewFile" },
		branch = "v3.x",

		config = function()
			local lsp = require("lsp-zero")
			lsp.preset("recommended")
			local on_attach = require("jb.lsputils").on_attach
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
				callback = function(_, _, _) end,
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
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{ "onsails/lspkind.nvim" }, -- Formating LSP Menu
			{ "b0o/schemastore.nvim", ft = { "json", "jsonc", "yaml" } },
		},
		config = function()
			require("lsp-zero").extend_lspconfig()

			-- Rust Analyzer Setup
			-- require("plugins.lsp.settings.rust")

			-- JavaScript, TypeScript, TailwindCSS
			require("plugins.lsp.settings.typescript")

			-- JSON and YAML
			require("plugins.lsp.settings.json_and_yaml")

			-- Python Setup
			require("plugins.lsp.settings.python")

			-- Vue Setup
			require("plugins.lsp.settings.volar")
		end,
	},
}
