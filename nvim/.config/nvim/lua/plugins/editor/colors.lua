function ColorMyPencils(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- ColorMyPencils('tokyonight-night')
ColorMyPencils()

local TelescopePrompt = {
	TelescopeBorder = {
		fg = "#191724",
		bg = "#191724",
	},

	TelescopePromptBorder = {
		fg = "#252434",
		bg = "#252434",
	},

	TelescopePromptNormal = {
		fg = "#e0def4", -- Rose Pine Foreground
		bg = "#252434",
	},

	TelescopePromptPrefix = {
		fg = "#f9929b", -- Rose Pine Red
		bg = "#252434",
	},

	TelescopeNormal = { bg = "#191724" },

	TelescopePreviewTitle = {
		fg = "#191724", -- Rose Pine Lighter Grey
		bg = "#9ccfd8",
	},

	TelescopePromptTitle = {
		fg = "#191724",
		bg = "#f9929b",
	},

	TelescopeResultsTitle = {
		fg = "#d2a8b3", -- Rose Pine Pink
		bg = "#2a2938", -- Rose Pine Darker Background
	},

	TelescopeSelection = { bg = "#2a2938", fg = "#e0def4" },

	TelescopeResultsDiffAdd = {
		fg = "#b4be82", -- Rose Pine Green
	},

	TelescopeResultsDiffChange = {
		fg = "#e0def4", -- Rose Pine Foreground
	},

	TelescopeResultsDiffDelete = {
		fg = "#ef5350", -- Rose Pine Red
	},
}

for hl, col in pairs(TelescopePrompt) do
	vim.api.nvim_set_hl(0, hl, col)
end
