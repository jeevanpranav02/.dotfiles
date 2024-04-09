return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",

	config = function()
		require("silicon").setup({
			font = "JetBrainsMono NFM=34;",
		})
	end,
}
