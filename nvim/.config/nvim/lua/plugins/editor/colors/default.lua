return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = true,
		config = function()
			if not pcall(require, "rose-pine") then
				return
			end
			ColorMyPencils("rose-pine")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		config = function()
			if not pcall(require, "catppuccin") then
				return
			end
			ColorMyPencils("catppuccin")
		end,
	},
	{ "folke/tokyonight.nvim", lazy = true },
}
