return {
	"nvim-treesitter/nvim-treesitter",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/playground",
		"windwp/nvim-ts-autotag",
	},
	config = function()
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"java",
				"html",
				"json",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"rust",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"cmake",
				"c",
				"dart",
				"bash",
				"markdown",
				"markdown_inline",
				"php",
				"norg",
			},
			ignore_install = { "haskell" },
			sync_install = false,
			auto_install = false,
			highlight = {
				enable = true,
				---@diagnostic disable-next-line: unused-local
				disable = function(_lang, bufnr) -- Disable in files with more than 5K
					return vim.api.nvim_buf_line_count(bufnr) > 5000
				end,
				additional_vim_regex_highlighting = false,
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Leader>ns", -- set to `false` to disable one of the mappings
					node_incremental = "<Leader>ni",
					scope_incremental = "<Leader>nc",
					node_decremental = "<Leader>nd",
				},
			},
		})

		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

		parser_config.blade = {
			install_info = {
				url = "https://github.com/EmranMR/tree-sitter-blade",
				files = { "src/parser.c" },
				branch = "main",
			},
			filetype = "blade",
		}

		vim.filetype.add({
			pattern = {
				[".*%.blade%.php"] = "blade",
				[".*%.cshtml%.cs"] = "cs",
				["*%.cshtml"] = "html",
			},
		})

		require("nvim-ts-autotag").setup({
			filetypes = {
				"html",
				"xml",
				"javascript",
				"typescript",
				"javascriptreact",
				"typescriptreact",
				"svelte",
				"vue",
				"blade",
				"php",
			},
		})
	end,
}
