return {
	"williamboman/mason.nvim",
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim" },
	},
	config = function()
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
		})
	end,
}
