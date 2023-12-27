return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		require("lint").linters_by_ft = {
			php = { "phpcs" },
			blade = { "phpcs" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				local file_name = vim.fn.expand("%:t")
				if file_name ~= "*.py" then
					require("lint").try_lint()
				end
			end,
		})
	end,
}
