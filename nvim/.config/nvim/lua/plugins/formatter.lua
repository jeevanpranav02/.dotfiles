require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		-- Use a sub-list to run only the first available formatter
		-- javascript = { { "prettierd", "prettier" } },
	},
	format_on_save = function(bufnr)
		-- Disable autoformat on certain filetypes
		local ignore_filetypes = { "sql", "java" }
		if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
			return
		end
		-- Disable autoformat for files in a certain path
		local bufname = vim.api.nvim_buf_get_name(bufnr)
		if bufname:match("/node_modules/") then
			return
		end
		if bufname:match("/.git/") then
			return
		end
		if bufname:match("/.venv/") then
			return
		end
		if bufname:match("/__pycache__/") then
			return
		end
		return { timeout_ms = 500, lsp_fallback = true }
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.lua", "*.py", "*.sql" },
	callback = function(args)
		require("conform").format({ lsp_fallback = true, bufnr = args.buf })
	end,
})
