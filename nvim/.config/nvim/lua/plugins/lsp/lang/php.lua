return {
	{
		"phpactor/phpactor",
		build = "composer install --no-dev --optimize-autoloader",
		lazy = true,
		ft = "php",
		keys = {
			{ "<Leader>pm", ":PhpactorContextMenu<CR>" },
			{ "<Leader>pn", ":PhpactorClassNew<CR>" },
		},

		config = function()
			local lspconfig = require("lspconfig")

			local on_attach = require("jb.lsputils").on_attach

			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- Php and Laravel Setup
			lspconfig.intelephense.setup({
				commands = {
					IntelephenseIndex = {
						function()
							vim.lsp.buf.execute_command({ command = "intelephense.index.workspace" })
						end,
					},
				},
				on_attach = on_attach,
				capabilities = capabilities,
			})

			lspconfig.phpactor.setup({
				capabilities = capabilities,
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					client.server_capabilities.completionProvider = false
					client.server_capabilities.hoverProvider = false
					client.server_capabilities.implementationProvider = false
					client.server_capabilities.referencesProvider = false
					client.server_capabilities.renameProvider = false
					client.server_capabilities.selectionRangeProvider = false
					client.server_capabilities.signatureHelpProvider = false
					client.server_capabilities.typeDefinitionProvider = false
					client.server_capabilities.workspaceSymbolProvider = false
					client.server_capabilities.definitionProvider = false
					client.server_capabilities.documentHighlightProvider = false
					client.server_capabilities.documentSymbolProvider = false
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
				init_options = {
					["language_server_phpstan.enabled"] = false,
					["language_server_psalm.enabled"] = false,
				},
				handlers = {
					["textDocument/publishDiagnostics"] = function() end,
				},
			})
		end,
	},
	{
		"adalessa/laravel.nvim",
		lazy = true,
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"tpope/vim-dotenv",
			"MunifTanjim/nui.nvim",
		},
		cmd = { "Sail", "Artisan", "Composer", "Npm", "Yarn", "Laravel" },
		keys = {
			{ "<leader>la", ":Laravel artisan<cr>" },
			{ "<leader>lr", ":Laravel routes<cr>" },
			{ "<leader>lm", ":Laravel related<cr>" },
			{
				"<leader>lt",
				function()
					require("laravel.tinker").send_to_tinker()
				end,
				mode = "v",
				desc = "Laravel Application Routes",
			},
		},
		config = function()
			require("laravel").setup()
			require("telescope").load_extension("laravel")
		end,
	},
}
