-- This file can be loaded by calling `lua require('plugins')` from your init.vim
vim.opt.signcolumn = "yes"

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope for Fuzzy Finding
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'nvim-telescope/telescope-media-files.nvim' }
    use { 'nvim-lua/popup.nvim' }
    --File browsing
    use { 'nvim-telescope/telescope-file-browser.nvim' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- Theme
    use({
        'rose-pine/neovim',
        as = 'rose-pine'
    })
    use('folke/tokyonight.nvim')
    use('folke/zen-mode.nvim')

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', {
        run = ':TSUpdate'
    })
    use("nvim-treesitter/nvim-treesitter-context");
    use('nvim-treesitter/playground')

    -- Trouble for Telescope
    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
            }
        end
    })

    -- Flutter Packer
    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
    }

    -- Harpoon
    use 'ThePrimeagen/harpoon'

    -- UndoTree similar to GitBranches
    use("mbbill/undotree")

    -- For Pair Parenthesis
    use("windwp/nvim-autopairs")

    -- Git support
    use("tpope/vim-fugitive")

    -- Java DT Language Server
    use('mfussenegger/nvim-dap')
    use('mfussenegger/nvim-jdtls')

    -- Colorizer
    use('NvChad/nvim-colorizer.lua')

    -- LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        requires = { -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = ":MasonUpdate"
            },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },
            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
            { 'honza/vim-snippets' },

            -- Formating LSP Menu
            { 'onsails/lspkind.nvim' },
        }
    }

    -- Lua line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- Comments
    use { 'numToStr/Comment.nvim' }

    -- Org mode
    use {
        "nvim-neorg/neorg",
        run = ":Neorg sync-parsers",
        requires = "nvim-lua/plenary.nvim",
    }


    -- Laravel support
    use('adalessa/laravel.nvim')
end)
