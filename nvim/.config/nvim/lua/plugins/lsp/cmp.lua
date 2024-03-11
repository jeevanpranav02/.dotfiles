return {
	"hrsh7th/nvim-cmp",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-emoji" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "roobert/tailwindcss-colorizer-cmp.nvim" },
	},
	opts = function()
		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		return {
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
			}),
			sources = {
				-- { name = "cody" },
				{ name = "luasnip", option = { use_show_condition = false } },
				{ name = "nvim_lsp" },
				{ name = "path" },
				-- { name = "copilot" },
				{ name = "buffer", keyword_length = 5 },
				{ name = "emoji" },
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			formatting = {
				expandable_indicator = true,
				fields = { "abbr", "kind", "menu" },
				-- Youtube: How to set up nice formatting for your sources.
				format = require("lspkind").cmp_format({
					with_text = true,
					menu = {
						buffer = "[buf]",
						nvim_lsp = "[LSP]",
						nvim_lua = "[api]",
						path = "[path]",
						cargo = "[cargo]",
						luasnip = "[snip]",
						cody = "[cody]",
						emoji = "[emoji]",
					},
				}),
			},

			---@diagnostic disable-next-line: missing-fields
			sorting = {
				-- TODO: Would be cool to add stuff like "See variable names before method names" in rust, or something like that.
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,

					-- copied from cmp-under, but I don't think I need the plugin for this.
					-- I might add some more of my own.
					function(entry1, entry2)
						local _, entry1_under = entry1.completion_item.label:find("^_+")
						local _, entry2_under = entry2.completion_item.label:find("^_+")
						entry1_under = entry1_under or 0
						entry2_under = entry2_under or 0
						if entry1_under > entry2_under then
							return false
						elseif entry1_under < entry2_under then
							return true
						end
					end,

					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
		}
	end,
	config = function(_, opts)
		for _, source in ipairs(opts.sources) do
			source.group_index = source.group_index or 1
		end
		require("cmp").setup(opts)
		-- ---@diagnostic disable-next-line: missing-fields
		-- require("cmp").setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
		-- 	sources = {
		-- 		{ name = "dap" },
		-- 	},
		-- })
	end,
}
