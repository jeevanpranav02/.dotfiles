return {
	"supermaven-inc/supermaven-nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("supermaven-nvim").setup({
			keymaps = {
				accept_suggestion = "<Tab>",
				clear_suggestion = "<C-]>",
			},
		})
	end,
}
