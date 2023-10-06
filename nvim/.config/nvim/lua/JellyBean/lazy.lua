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
    -- Telescope for Fuzzy Finding
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.3',
        -- or                            , branch = '0.1.x',
        dependencies = { { 'nvim-lua/plenary.nvim' } }
    },
    'nvim-telescope/telescope-media-files.nvim',
    'nvim-lua/popup.nvim',
    --File browsing
    'nvim-telescope/telescope-file-browser.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    -- Theme
    {
        'rose-pine/neovim',
        name = 'rose-pine'
    },
    'folke/tokyonight.nvim',
    'folke/zen-mode.nvim',
    'folke/twilight.nvim',

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate'
    },
    "nvim-treesitter/nvim-treesitter-context",
    'nvim-treesitter/playground',

    -- Trouble for Telescope
    "folke/trouble.nvim",

    -- Flutter Packer
    {
        'akinsho/flutter-tools.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
    },

    -- Harpoon
    "ThePrimeagen/harpoon",

    -- UndoTree similar to GitBranches
    "mbbill/undotree",

    -- For Pair Parenthesis
    "windwp/nvim-autopairs",

    -- Git support
    "tpope/vim-fugitive",

    -- Java DT Language Server
    'mfussenegger/nvim-dap',
    'mfussenegger/nvim-jdtls',

    -- Colorizer
    'NvChad/nvim-colorizer.lua',

    -- LSP
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },

    { 'VonHeikemen/lsp-zero.nvim',                branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    -- Snippets
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
    { 'honza/vim-snippets' },

    -- Formating LSP Menu
    { 'onsails/lspkind.nvim' },

    -- Lua line
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons'},
    },
    -- Comments
    'numToStr/Comment.nvim',

    -- Org mode
    {
        "nvim-neorg/neorg",
        build = ":Neorg sync-parsers",
        dependencies = "nvim-lua/plenary.nvim",
    },

    -- Laravel support
    'adalessa/laravel.nvim',

    -- SHitty Rain
    'eandrju/cellular-automaton.nvim',

}

require("lazy").setup(plugins, opts)
