local cmp = require("cmp")
local cmp_action = require("lsp-zero").cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local icons = require("ui.icons")
---@diagnostic disable-next-line: missing-fields
cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-f>"] = cmp_action.luasnip_jump_forward(),
		["<C-b>"] = cmp_action.luasnip_jump_backward(),
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	}),
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "buffer", keyword_length = 5 },
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		expandable_indicator = true,
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			vim_item.kind = icons.kind[vim_item.kind]
			vim_item.menu = ({
				nvim_lsp = "",
				nvim_lua = "",
				luasnip = "",
				buffer = "",
				path = "",
				emoji = "",
			})[entry.source.name]

			if vim.tbl_contains({ "nvim_lsp" }, entry.source.name) then
				local duplicates = {
					buffer = 1,
					path = 1,
					nvim_lsp = 0,
					luasnip = 1,
				}

				local duplicates_default = 0

				---@diagnostic disable-next-line: assign-type-mismatch
				vim_item.dup = duplicates[entry.source.name] or duplicates_default
			end

			if vim.tbl_contains({ "nvim_lsp" }, entry.source.name) then
				local words = {}
				for word in string.gmatch(vim_item.word, "[^-]+") do
					table.insert(words, word)
				end

				local color_name, color_number
				if
					words[2] == "x"
					or words[2] == "y"
					or words[2] == "t"
					or words[2] == "b"
					or words[2] == "l"
					or words[2] == "r"
				then
					color_name = words[3]
					color_number = words[4]
				else
					color_name = words[2]
					color_number = words[3]
				end

				if color_name == "white" or color_name == "black" then
					local color
					if color_name == "white" then
						color = "ffffff"
					else
						color = "000000"
					end

					local hl_group = "lsp_documentColor_mf_" .. color
					-- vim.api.nvim_set_hl(0, hl_group, { fg = "#" .. color, bg = "#" .. color })
					vim.api.nvim_set_hl(0, hl_group, { fg = "#" .. color, bg = "NONE" })
					vim_item.kind_hl_group = hl_group

					-- make the color square 2 chars wide
					vim_item.kind = string.rep("▣", 1)

					return vim_item
				elseif #words < 3 or #words > 4 then
					-- doesn't look like this is a tailwind css color
					return vim_item
				end

				if not color_name or not color_number then
					return vim_item
				end

				local color_index = tonumber(color_number)
				local tailwindcss_colors = require("tailwindcss-colorizer-cmp.colors").TailwindcssColors

				if not tailwindcss_colors[color_name] then
					return vim_item
				end

				if not tailwindcss_colors[color_name][color_index] then
					return vim_item
				end

				local color = tailwindcss_colors[color_name][color_index]

				local hl_group = "lsp_documentColor_mf_" .. color
				-- vim.api.nvim_set_hl(0, hl_group, { fg = "#" .. color, bg = "#" .. color })
				vim.api.nvim_set_hl(0, hl_group, { fg = "#" .. color, bg = "NONE" })

				vim_item.kind_hl_group = hl_group

				-- make the color square 2 chars wide
				vim_item.kind = string.rep("▣", 1)

				-- return vim_item
			end

			if entry.source.name == "copilot" then
				vim_item.kind = icons.git.Octoface
				vim_item.kind_hl_group = "CmpItemKindCopilot"
			end

			if entry.source.name == "cmp_tabnine" then
				vim_item.kind = icons.misc.Robot
				vim_item.kind_hl_group = "CmpItemKindTabnine"
			end

			if entry.source.name == "crates" then
				vim_item.kind = icons.misc.Package
				vim_item.kind_hl_group = "CmpItemKindCrate"
			end

			if entry.source.name == "lab.quick_data" then
				vim_item.kind = icons.misc.CircuitBoard
				vim_item.kind_hl_group = "CmpItemKindConstant"
			end

			if entry.source.name == "emoji" then
				vim_item.kind = icons.misc.Smiley
				vim_item.kind_hl_group = "CmpItemKindEmoji"
			end

			return vim_item
		end,
	},
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
	experimental = {
		-- I like the new menu better! Nice work hrsh7th
		native_menu = false,

		-- Let's play with this for a day or two
		ghost_text = false,
	},
})
