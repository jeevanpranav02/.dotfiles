local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	--============================= Telescope =================================

	{
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
	},

	-- Register Content Viewer Extension
	{
		"AckslD/nvim-neoclip.lua",
		lazy = false,
		dependencies = {
			{ "kkharji/sqlite.lua", module = "sqlite" },
		},
		config = function()
			require("neoclip").setup()
		end,
	},

	--=============================== Colors ==================================

	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
	},
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "folke/tokyonight.nvim" },
	{ "folke/zen-mode.nvim" },
	{ "folke/twilight.nvim" },
	{ "tjdevries/colorbuddy.vim" },
	{ "tjdevries/gruvbuddy.nvim" },

	--================================ UI =====================================

	-- { "nvimdev/dashboard-nvim", event = "VimEnter" },
	{ "onsails/lspkind.nvim" }, -- Formating LSP Menu
	-- For loading LSP
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		lazy = true,
		event = "LspAttach",
	},
	{ "tjdevries/express_line.nvim", dev = false },
	{ "nvim-tree/nvim-web-devicons" },

	--============================ Treesitter =================================

	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context",
			"nvim-treesitter/playground",
		},
	},

	--=============================== LSP =====================================

	{
		"VonHeikemen/lsp-zero.nvim",
		event = { "BufReadPre", "BufNewFile" },
		branch = "v3.x",
		dependencies = {
			{ "neovim/nvim-lspconfig", event = { "BufReadPre", "BufNewFile" } },
		},
	},
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
	},
	{ "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
	{ "roobert/tailwindcss-colorizer-cmp.nvim", event = "InsertEnter" },
	{ "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-buffer", event = "InsertEnter" },
	{ "hrsh7th/cmp-emoji", event = "InsertEnter" },
	{ "L3MON4D3/LuaSnip", event = "InsertEnter" },
	{ "rafamadriz/friendly-snippets" },
	{ "honza/vim-snippets" },

	--=============================== DAP =====================================

	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			{ "rcarriga/nvim-dap-ui" },
			{ "rcarriga/cmp-dap" },
			{ "theHamsta/nvim-dap-virtual-text" },
			{ "mfussenegger/nvim-dap-python" },
		},
	},

	--========================= Language Specific ============================

	------------------------------- Flutter ----------------------------------
	{
		"akinsho/flutter-tools.nvim",
		ft = "dart",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"dart-lang/dart-vim-plugin",
			"nvim-lua/plenary.nvim",
			"RobertBrunhage/flutter-riverpod-snippets",
		},
	},

	--------------------------------- Java ------------------------------------

	{ "mfussenegger/nvim-jdtls" },

	--------------------------------- SQL -------------------------------------

	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
		},
	},

	--------------------------- PHP and Laravel -------------------------------

	{
		"phpactor/phpactor",
		build = "composer install --no-dev --optimize-autoloader",
		ft = "php",
		keys = {
			{ "<Leader>pm", ":PhpactorContextMenu<CR>" },
			{ "<Leader>pn", ":PhpactorClassNew<CR>" },
		},
	},

	{ "adalessa/laravel.nvim", ft = "php" },

	------------------------------- Python ------------------------------------

	{ "AckslD/swenv.nvim" },

	-------------------------------- JSON -------------------------------------

	{ "b0o/schemastore.nvim", ft = "json" },

	--============================= Miscellaneous =============================
	-- Diagnostics Viewer
	{ "folke/trouble.nvim" },

	-- Linter
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
	},
	-- Formatter
	{ "stevearc/conform.nvim", event = { "BufReadPre", "BufNewFile" } },

	-- Log Highlighter
	{ "mtdl9/vim-log-highlighting", lazy = false },

	-- Comments
	{ "numToStr/Comment.nvim", event = { "BufReadPre", "BufNewFile" } },

	-- Manage multiple terminal windows
	{ "akinsho/toggleterm.nvim" },

	-- GOATED plugins
	{ "ThePrimeagen/harpoon", branch = "harpoon2" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-repeat" },
	{ "folke/neodev.nvim", ft = "lua" },

	-- Autoalign text something like a table
	{ "godlygeek/tabular" },

	--Git signs
	{ "lewis6991/gitsigns.nvim", event = { "BufReadPre", "BufNewFile" } },

	-- UndoTree similar to GitBranches
	{ "mbbill/undotree" },

	-- For Pair Parenthesis
	{ "windwp/nvim-autopairs", event = { "InsertEnter" } },

	-- Colorizer
	{ "NvChad/nvim-colorizer.lua", event = { "BufReadPre", "BufNewFile" } },

	-- Neorg mode
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = "nvim-lua/plenary.nvim",
	},

	-- Copilot support
	{
		"github/copilot.vim",
		event = "InsertEnter",
	},
	-- Cody - SOURCEGRAPH
	{
		"sourcegraph/sg.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
		},
	},

	-- File Explorer
	{ "nvim-tree/nvim-tree.lua", dependencies = "nvim-tree/nvim-web-devicons" },

	-- Shitty Rain
	{ "eandrju/cellular-automaton.nvim" },
}

require("lazy").setup(plugins, {
	ui = {
		icons = {
			ft = "",
			lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
		},
	},
	change_detection = {
		enabled = false,
		notify = true,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"tohtml",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				-- "netrw",
				-- "netrwPlugin",
				-- "netrwSettings",
				-- "netrwFileHandlers",
				"matchit",
				"tar",
				"tarPlugin",
				"rrhelper",
				"spellfile_plugin",
				"vimball",
				"vimballPlugin",
				"zip",
				"zipPlugin",
				"tutor",
				"rplugin",
				"syntax",
				"synmenu",
				"optwin",
				"compiler",
				"bugreport",
				"ftplugin",
			},
		},
	},
})
