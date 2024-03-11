return {
	"j-hui/fidget.nvim",
	config = function()
		require("fidget").setup({
			notification = {
				window = {
					relative = "editor",
					align = "bottom",
				},
			},
		})
	end,
}
