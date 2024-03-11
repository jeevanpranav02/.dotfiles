return {
	"folke/trouble.nvim",
	lazy = true,
	event = "LspAttach",
	config = function()
		local trouble = require("trouble")
		trouble.setup({
			fold_open = "v",
			fold_closed = ">",
			signs = {
				error = "error",
				warning = "warn",
				hint = "hint",
				information = "info",
			},
			icons = false,
			use_diagnostic_signs = true,
		})

		vim.keymap.set("n", "<leader>xx", function()
			require("trouble").toggle()
		end)
		-- vim.keymap.set("n", "[d", function()
		-- 	require("trouble").previous({ skip_groups = true, jump = true })
		-- end)
		-- vim.keymap.set("n", "]d", function()
		-- 	require("trouble").next({ skip_groups = true, jump = true })
		-- end)
		-- vim.keymap.set("n", "<leader>xw", function()
		-- 	require("trouble").open("workspace_diagnostics")
		-- end)
		-- vim.keymap.set("n", "<leader>xd", function()
		-- 	require("trouble").open("document_diagnostics")
		-- end)
		-- vim.keymap.set("n", "<leader>xq", function()
		-- 	require("trouble").open("quickfix")
		-- end)
		-- vim.keymap.set("n", "<leader>xl", function()
		-- 	require("trouble").open("loclist")
		-- end)
		-- vim.keymap.set("n", "gR", function()
		-- 	require("trouble").open("lsp_references")
		-- end)
	end,
}
