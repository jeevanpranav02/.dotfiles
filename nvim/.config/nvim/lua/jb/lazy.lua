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

	{ "nvimdev/dashboard-nvim", event = "VimEnter" },
	--[[ { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} }, ]]
	{ "stevearc/dressing.nvim" }, -- optional for vim.ui.select
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

	{ "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },

	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
	},
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "roobert/tailwindcss-colorizer-cmp.nvim" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-cmdline" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-emoji" },
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },
	{ "honza/vim-snippets" },

	--=============================== DAP =====================================

	{
		"mfussenegger/nvim-dap",
		lazy = true,
		event = "VeryLazy",
		dependencies = {
			{ "rcarriga/nvim-dap-ui" },
			{ "rcarriga/cmp-dap" },
			{ "theHamsta/nvim-dap-virtual-text" },
			{ "mfussenegger/nvim-dap-python" },
		},
	},

	--========================= Language Specific ============================

	--------------------------------- Rust -----------------------------------

	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		lazy = false,
	},

	------------------------------- Flutter ----------------------------------
	{
		"akinsho/flutter-tools.nvim",
		ft = "dart",
		lazy = false,
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

	{ "adalessa/laravel.nvim" },

	------------------------------- Python ------------------------------------

	{ "AckslD/swenv.nvim" },

	-------------------------------- JSON -------------------------------------

	{ "b0o/schemastore.nvim" },

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
	{ "stevearc/conform.nvim" },

	-- Log Highlighter
	{ "mtdl9/vim-log-highlighting", lazy = false },

	-- Comments
	{ "numToStr/Comment.nvim" },

	-- Manage multiple terminal windows
	{ "akinsho/toggleterm.nvim" },

	-- GOATED plugins
	{ "ThePrimeagen/harpoon", branch = "harpoon2" },
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-surround" },
	{ "folke/neodev.nvim", opts = {} },

	-- UndoTree similar to GitBranches
	{ "mbbill/undotree" },

	-- For Pair Parenthesis
	{ "windwp/nvim-autopairs", event = { "InsertEnter" } },

	-- Colorizer
	{ "NvChad/nvim-colorizer.lua" },

	-- Neorg mode
	{
		"nvim-neorg/neorg",
		build = ":Neorg sync-parsers",
		dependencies = "nvim-lua/plenary.nvim",
	},

	-- Copilot support
	{
		"github/copilot.vim",
	},

	-- File Explorer
	{ "nvim-tree/nvim-tree.lua", dependencies = "nvim-tree/nvim-web-devicons" },

	-- Shitty Rain
	{ "eandrju/cellular-automaton.nvim" },
}

-- require("lazy").setup(plugins, {
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
