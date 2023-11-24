local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>gr", builtin.lsp_references, {})
vim.keymap.set("n", "<leader>gi", builtin.lsp_implementations, {})

vim.keymap.set("n", "<leader>pm", "<cmd>Telescope media_files<CR>")
vim.keymap.set("n", "<leader>pd", "<cmd>Telescope diagnostics<CR>")
vim.keymap.set("n", "<leader>=", "<cmd>Telescope registers<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>Telescope luasnip theme=ivy initial_mode=normal <CR>")
vim.api.nvim_set_keymap(
	"n",
	"<leader>fb",
	"<cmd>lua require 'telescope'.extensions.file_browser.file_browser()<CR>",
	{ noremap = true }
)

require("telescope").setup({
	defaults = {
		-- winblend = 40,
		prompt_position = "top",
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		file_ignore_patterns = {
			"node_modules",
			"target",
			"build",
			"windows",
			"linux",
			"ios",
			"macos",
			"vendor",
		},
		initial_mode = "normal",
		layout_config = {
			width = 0.8,
		},
	},
	pickers = {
		find_files = {
			theme = "dropdown",
			previewer = false,
			layout_config = {
				height = 0.5,
				width = 120,
			},
		},
		grep_string = {
			layout_options = {
				preview_width = 0.4,
			},
		},
		git_files = {
			layout_options = {
				preview_width = 0.4,
			},
		},
	},
	extensions = {
		media_files = {
			filetypes = { "svg", "png", "webp", "jpg", "jpeg" },
			find_cmd = "rg",
		},
		file_browser = {
			theme = "ivy",
			grouped = true,
			previewer = false,
			initial_browser = "tree",
			auto_depth = true,
			depth = 1,
		},
		fzf = {
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
		},
	},
})

require("telescope").load_extension("media_files")
require("telescope").load_extension("harpoon")
require("telescope").load_extension("neoclip")
require("telescope").load_extension("flutter")
require("telescope").load_extension("dap")
require("telescope").load_extension("luasnip")
