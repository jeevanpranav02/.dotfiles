local _enable_lazy = { true, true, true, false }
return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = _enable_lazy[1],
		config = function()
			if not pcall(require, "rose-pine") then
				return
			end
			require("rose-pine").setup({
				disable_background = true,
				disable_float_background = true,
				disable_italics = true,
			})
			ColorMyPencils("rose-pine")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = _enable_lazy[2],
		config = function()
			if not pcall(require, "catppuccin") then
				return
			end
			require("catppuccin").setup({
				transparent_background = true,
			})
			ColorMyPencils("catppuccin")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = _enable_lazy[3],
		config = function()
			if not pcall(require, "tokyonight") then
				return
			end
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				transparent = true,
			})
			ColorMyPencils("tokyonight")
		end,
	},
	{
		"tjdevries/colorbuddy.vim",
		lazy = _enable_lazy[4],
		config = function()
			vim.cmd.colorscheme("gruvbuddy")

			local colors = require("colorbuddy.color").colors
			local Group = require("colorbuddy.group").Group
			local groups = require("colorbuddy.group").groups
			local styles = require("colorbuddy.style").styles
			local Color = require("colorbuddy.color").Color

			-- Custom Colors
			Color.new("skyblue", "#569CD6")
			Color.new("lightblue", "#9CDCFE")
			Color.new("pink", "#C586C0")
			Color.new("front", "#D4D4D4")

			Group.new("TabLineFill", nil, nil)

			-- -- General Stuff
			Group.new("NormalFloat", colors.superwhite, nil)
			Group.new("ColorColumn", nil, colors.gray2)
			Group.new("Folded", colors.gray3, nil)

			-- Completion -- cmp-nvim
			Group.new("CmpItemAbbr", groups.Comment)
			Group.new("CmpItemAbbrDeprecated", groups.Error)
			Group.new("CmpItemAbbrMatch", colors.pink, nil)
			Group.new("CmpItemAbbrMatchFuzzy", groups.CmpItemAbbr.fg:dark(), nil, styles.italic)
			Group.new("CmpItemMenu", groups.NonText)
			Group.new("CmpItemKind", groups.Special)

			-- Harpoon
			Group.new("HarpoonWindow", colors.superwhite, nil)
			Group.new("HarpoonBorder", colors.gray3, nil)
			Group.new("HarpoonTitle", colors.gray3, nil)

			Group.new("TreesitterContext", nil, groups.Normal.bg:light())
			Group.new("TreesitterContextLineNumber", colors.blue)

		end,
	},
}
