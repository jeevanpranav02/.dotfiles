return {
	"williamboman/mason.nvim",
	dependencies = {
		{ "VonHeikemen/lsp-zero.nvim", },
		{ "williamboman/mason-lspconfig.nvim" },
	},
	config = function()
		local lsp = require("lsp-zero")
		require("mason").setup({
			ui = {
				border = "rounded",
				icons = {
					package_installed = require("ui.icons").ui.BoldCheck,
					package_pending = require("ui.icons").ui.BookMark,
					package_uninstalled = require("ui.icons").ui.NotLoaded,
				},
			},
		})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"tsserver",
				"volar",
				"tailwindcss",
				"vale_ls",
				"omnisharp",
				"html",
				"lua_ls",
				"yamlls",
			},
			handlers = {
				lsp.default_setup,
			},
		})
	end
}
