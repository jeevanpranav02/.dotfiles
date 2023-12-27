return {
	"j-hui/fidget.nvim",
	tag = "legacy",
	lazy = true,
	event = "LspAttach",
	config = function()
		require("fidget").setup({
			text = {
				spinner = "moon",
			},
			align = {
				bottom = true,
			},
			window = {
				relative = "editor",
			},
		})
	end,
}
