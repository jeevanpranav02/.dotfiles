local lspconfig = require("lspconfig")

local on_attach = require("jb.lsputils").on_attach

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
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
