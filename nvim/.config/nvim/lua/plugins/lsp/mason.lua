local lsp = require("lsp-zero")
require("mason").setup({})
require("mason-lspconfig").setup({
	ensure_installed = {
		"tsserver",
		"volar",
		"tailwindcss",
		"vale_ls",
		"html",
		"lua_ls",
		"yamlls",
	},
	handlers = {
		lsp.default_setup,
	},
})
