require("lint").linters_by_ft = {
	javascript = { "volar" },
	typescript = { "volar" },
	typescriptreact = { "volar" },
	vue = { "volar" },
	html = { "vale" },
	css = { "volar" },
	scss = { "volar" },
	sass = { "stylelint" },
	markdown = { "vale" },
	json = { "jsonlint" },
	yaml = { "yamllint" },
	php = { "phpcs" },
	blade = { "phpcs" },
	twig = { "phpcs" },
	rust = { "cargo" },
	go = { "golangcilint" },
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
