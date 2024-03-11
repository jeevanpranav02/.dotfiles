return {
	"nvim-telescope/telescope.nvim",
	lazy = false,
	tag = "0.1.3",
	-- or                            , branch = '0.1.x',
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- Telescope Extensions
		-- Media Files Viewer
		"nvim-telescope/telescope-media-files.nvim",

		-- DAP Extension
		"nvim-telescope/telescope-dap.nvim",

		-- LuaSnip Extension
		"benfowler/telescope-luasnip.nvim",
		-- File Browser
		"nvim-telescope/telescope-file-browser.nvim",
		-- UI select
		"nvim-telescope/telescope-ui-select.nvim",
		-- FZF Extension
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
		vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
		vim.keymap.set("n", "<leader>pb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>pw", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>pW", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })
		end)
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
			{ noremap = true, desc = "File browser" }
		)

		require("telescope").setup({
			defaults = {
				prompt_prefix = "   ",
				selection_caret = "  ",
				selection_strategy = "reset",
				results_title = false,
				entry_prefix = "  ",
				border = {},
				borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				color_devicons = true,
				set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
				vimgrep_arguments = {
					"rg",
					"-L",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				sorting_strategy = "ascending",
				file_sorter = require("telescope.sorters").get_fuzzy_file,
				generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
				path_display = { "absolute" },
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
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
					horizontal = {
						prompt_position = "bottom",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
				},
			},
			pickers = {
				buffers = {
					show_all_buffers = true,
					sort_lastused = true,
					mappings = {
						n = {
							["<c-d>"] = require("telescope.actions").delete_buffer,
						},
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
					fuzzy = false, -- false will only do exact matching
					override_generic_sorter = false, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
			},
		})

		require("telescope").load_extension("media_files")
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("dap")
	end,
}
