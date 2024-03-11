-- return {
-- 	{ "Hoffs/omnisharp-extended-lsp.nvim", lazy = false },
-- 	{
-- 		"nvim-treesitter/nvim-treesitter",
-- 		opts = function(_, opts)
-- 			if type(opts.ensure_installed) == "table" then
-- 				vim.list_extend(opts.ensure_installed, { "c_sharp" })
-- 			end
-- 		end,
-- 	},
-- 	{
-- 		"stevearc/conform.nvim",
-- 		opts = {
-- 			formatters_by_ft = {
-- 				cs = { "csharpier" },
-- 			},
-- 			formatters = {
-- 				csharpier = {
-- 					command = "dotnet-csharpier",
-- 					args = { "--write-stdout" },
-- 				},
-- 			},
-- 		},
-- 	},
-- 	{
-- 		"williamboman/mason.nvim",
-- 		opts = function(_, opts)
-- 			opts.ensure_installed = opts.ensure_installed or {}
-- 			table.insert(opts.ensure_installed, "csharpier")
-- 		end,
-- 	},
-- 	{
-- 		"neovim/nvim-lspconfig",
-- 		opts = {
-- 			servers = {
-- 				omnisharp = {
-- 					handlers = {
-- 						["textDocument/definition"] = function(...)
-- 							return require("omnisharp_extended").handler(...)
-- 						end,
-- 					},
-- 					keys = {
-- 						{
-- 							"gd",
-- 							function()
-- 								require("omnisharp_extended").telescope_lsp_definitions()
-- 							end,
-- 							desc = "Goto Definition",
-- 						},
-- 					},
-- 					enable_roslyn_analyzers = true,
-- 					organize_imports_on_format = true,
-- 					enable_import_completion = true,
-- 				},
-- 			},
-- 		},
-- 	},
-- }
return {
	"iabdelkareem/csharp.nvim",
	dependencies = {
		"williamboman/mason.nvim", -- Required, automatically installs omnisharp
		"mfussenegger/nvim-dap",
		"Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
	},
	config = function()
		require("mason").setup() -- Mason setup must run before csharp
		require("csharp").setup({
			lsp = {
				on_attach = require("jb.lsputils").on_attach,
				capabilities = require("jb.lsputils").capabilities,
			},
		})
	end,
}
