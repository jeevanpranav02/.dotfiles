return {
	-- {
	-- 	"williamboman/mason.nvim",
	-- 	dependencies = {
	-- 		{ "williamboman/mason-lspconfig.nvim" },
	-- 	},
	-- 	config = function()
	-- 		require("mason").setup({
	-- 			ui = {
	-- 				border = "rounded",
	-- 				icons = {
	-- 					package_installed = require("ui.icons").ui.BoldCheck,
	-- 					package_pending = require("ui.icons").ui.BookMark,
	-- 					package_uninstalled = require("ui.icons").ui.NotLoaded,
	-- 				},
	-- 			},
	-- 		})
	-- 		require("mason-lspconfig").setup({
	-- 			ensure_installed = {
	-- 				"tsserver",
	-- 				"volar",
	-- 				"tailwindcss",
	-- 				"vale_ls",
	-- 				"omnisharp",
	-- 				"html",
	-- 				"lua_ls",
	-- 				"yamlls",
	-- 			},
	-- 		})
	-- 	end,
	-- },
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

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
				-- Use a sharp border with `FloatBorder` highlights
				border = "rounded",
			})

			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
				-- Use a sharp border with `FloatBorder` highlights
				border = "rounded",
			})

			-- Rust Analyzer Setup
			require("plugins.lsp.settings.rust")

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
