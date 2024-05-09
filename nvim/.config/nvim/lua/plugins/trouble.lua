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

		vim.keymap.set("n", "<leader>tt", function()
			require("trouble").toggle()
		end)
		-- vim.keymap.set("n", "[t", function()
		-- 	require("trouble").previous({ skip_groups = true, jump = true })
		-- end)
		-- vim.keymap.set("n", "]t", function()
		-- 	require("trouble").next({ skip_groups = true, jump = true })
		-- end)
		-- vim.keymap.set("n", "<leader>tw", function()
		-- 	require("trouble").open("workspace_diagnostics")
		-- end)
		-- vim.keymap.set("n", "<leader>td", function()
		-- 	require("trouble").open("document_diagnostics")
		-- end)
		-- vim.keymap.set("n", "<leader>tq", function()
		-- 	require("trouble").open("quickfix")
		-- end)
		-- vim.keymap.set("n", "<leader>tl", function()
		-- 	require("trouble").open("loclist")
		-- end)
		-- vim.keymap.set("n", "gR", function()
		-- 	require("trouble").open("lsp_references")
		-- end)
	end,
}
