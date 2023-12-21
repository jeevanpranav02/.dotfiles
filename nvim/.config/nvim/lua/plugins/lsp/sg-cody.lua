-- Toggle cody chat
vim.keymap.set("n", "<space>cc", function()
	require("sg.cody.commands").toggle()
end)

vim.keymap.set("n", "<space>cn", function()
	local name = vim.fn.input("chat name: ")
	require("sg.cody.commands").chat(name)
end)
-- vim.keymap.set("v", "<space>ca", ":CodyContext<CR>")
-- vim.keymap.set("v", "<space>ce", ":CodyExplain<CR>")

vim.keymap.set("n", "<space>ss", function()
	require("sg.extensions.telescope").fuzzy_search_results()
end)

local ok, msg = pcall(require, "sg")
if not ok then
	print("sg failed to load with:", msg)
	return
end

require("sg").setup({
	on_attach = require("plugins.lsp").on_attach,
	enable_cody = true,
})
