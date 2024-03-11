return {
	"windwp/nvim-autopairs",
	enabled = false,
	event = { "InsertEnter" },
	config = function()
		require("nvim-autopairs").setup({
			disable_filetype = { "TelescopePrompt", "vim" },
		})
	end,
}
