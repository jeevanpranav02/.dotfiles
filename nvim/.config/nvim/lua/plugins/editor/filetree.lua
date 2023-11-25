-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	sync_root_with_cwd = true,
	sort = {
		sorter = "name",
		folders_first = true,
		files_first = false,
	},
	view = {
		width = 30,
	},
	renderer = {
		add_trailing = true,
		group_empty = false,
		indent_width = 2,
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
		symlink_destination = true,
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " -> ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
			},
		},
	},
	actions = {
		open_file = {
			quit_on_open = false,
		},
	},
	filters = {
		dotfiles = true,
	},
	update_focused_file = {
		enable = true,
		update_root = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = false,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
		icons = {
			hint = "󰌶",
			info = "",
			warning = "",
			error = "✘",
		},
	},
	log = {
		enable = true,
		truncate = true,
		types = {
			diagnostics = true,
			git = true,
			profile = true,
			watcher = true,
		},
	},
})

vim.api.nvim_set_keymap("n", "<leader>q", ":NvimTreeToggle<cr>", { silent = true }) --Toggle tree
-- Transparent Background
vim.cmd([[hi NvimTreeNormal guibg=NONE ctermbg=NONE]])
