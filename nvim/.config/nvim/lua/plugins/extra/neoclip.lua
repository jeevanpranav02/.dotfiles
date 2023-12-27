return {
	"AckslD/nvim-neoclip.lua",
	lazy = true,
	dependencies = {
		{ "kkharji/sqlite.lua", module = "sqlite" },
	},
	config = function()
		require("neoclip").setup()
		require("telescope").load_extension("neoclip")
	end,
}

