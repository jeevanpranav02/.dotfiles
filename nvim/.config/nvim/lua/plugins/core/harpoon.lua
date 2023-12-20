--- Harpoon V1
-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")
--
-- vim.keymap.set("n", "<leader>a", mark.add_file)
-- vim.keymap.set("n", "<M-e>", ui.toggle_quick_menu, { desc = "Toggle Harpoon menu" })
--
-- vim.keymap.set("n", "<C-h>", function()
-- 	ui.nav_file(1)
-- end)
-- vim.keymap.set("n", "<C-t>", function()
-- 	ui.nav_file(2)
-- end)
-- vim.keymap.set("n", "<C-n>", function()
-- 	ui.nav_file(3)
-- end)
-- vim.keymap.set("n", "<C-s>", function()
-- 	ui.nav_file(4)
-- end)
--

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup({
	settings = {
		save_on_toggle = true,
	},
})
-- REQUIRED

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():append()
end)
vim.keymap.set("n", "<M-e>", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<C-h>", function()
	harpoon:list():select(1)
end)
vim.keymap.set("n", "<C-t>", function()
	harpoon:list():select(2)
end)
vim.keymap.set("n", "<C-n>", function()
	harpoon:list():select(3)
end)
vim.keymap.set("n", "<C-s>", function()
	harpoon:list():select(4)
end)

vim.api.nvim_set_hl(0, "HarpoonWindow", { fg = "none", bg = "none" })
vim.api.nvim_set_hl(0, "HarpoonBorder", { fg = "#ffffff", bg = "none" })
vim.api.nvim_set_hl(0, "HarpoonTitle", { fg = "#ffffff", bg = "none" })
