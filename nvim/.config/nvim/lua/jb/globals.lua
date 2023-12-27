LAZY_PLUGIN_SPEC = {}

function Spec(item)
	table.insert(LAZY_PLUGIN_SPEC, { import = item })
end

function ColorMyPencils(color)
	color = color or "zaibatsu"
	vim.cmd.colorscheme(color)

	if color == "rose-pine" then
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
	end
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
	vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalSB", { bg = "none" })

	-- NvimTree
	vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
end

local ok, plenary_reload = pcall(require, "plenary.reload")
local reloader = require
if ok then
	reloader = plenary_reload.reload_module
end

P = function(v)
	print(vim.inspect(v))
	return v
end

RELOAD = function(...)
	local ok, plenary_reload = pcall(require, "plenary.reload")
	if ok then
		reloader = plenary_reload.reload_module
	end

	return reloader(...)
end

R = function(name)
	RELOAD(name)
	return require(name)
end

ColorMyPencils()
