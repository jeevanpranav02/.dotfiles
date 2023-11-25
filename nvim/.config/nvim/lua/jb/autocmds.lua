local augroup = vim.api.nvim_create_augroup
local JellyBeanGroup = augroup("JellyBean", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

function R(name)
	require("plenary.reload").reload_module(name)
end

autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

autocmd({ "BufWritePre" }, {
	group = JellyBeanGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

vim.cmd([[
    augroup file_blade_php
      autocmd BufRead,BufNewFile *.blade.php setlocal ts=2 sts=2 sw=2 filetype=blade syntax=blade expandtab
    augroup END
]])
