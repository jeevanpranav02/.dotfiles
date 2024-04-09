return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	lazy = true,

	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED
		harpoon:setup({
			settings = {
				save_on_toggle = true,
				sync_on_ui_close = true,
			},
		})
		-- REQUIRED

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
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

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)

		-- Load harpoon into telescope
		require("telescope").load_extension("harpoon")
	end,

	keys = {
		{
			"<Leader>a",
			function()
				require("harpoon"):list():append()
			end,
			desc = "Add File to Harpoon",
		},
		{
			"<m-e>",
			function()
				require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
			end,
			desc = "Toggle Harpoon Menu",
		},
		{
			"<c-h>",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Go to Harpoon File 1",
		},
		{
			"<c-t>",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Go to Harpoon File 2",
		},
		{
			"<c-n>",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Go to Harpoon File 3",
		},
		{
			"<c-s>",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Go to Harpoon File 4",
		},
	},
}
