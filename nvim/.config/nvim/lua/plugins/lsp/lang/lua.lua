return {
	"folke/neodev.nvim",
	opts = {},
	config = function()
		require("neodev").setup({})
		local lspconfig = require("lspconfig")

		local on_attach = require("jb.lsputils").on_attach

		local capabilities = require("jb.lsputils").capabilities
		-- Lua Setup
		lspconfig.lua_ls.setup({
			on_attach = on_attach,
			capabilities = capabilities,
			settings = {
				Lua = {
					codeLens = { enable = true },
					hint = {
						enable = true,
						arrayIndex = "Literal",
						setType = false,
						paramName = "Disable",
						paramType = true,
					},
					format = { enable = false },
					diagnostics = {
						globals = {
							"vim",
							"P",
							"describe",
							"it",
							"before_each",
							"after_each",
							"packer_plugins",
							"pending",
						},
					},
					completion = { keywordSnippet = "Replace", callSnippet = "Replace" },
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})
	end,
}
