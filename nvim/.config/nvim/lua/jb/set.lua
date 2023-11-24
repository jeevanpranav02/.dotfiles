-- Clear guicursor
vim.opt.guicursor = ""

-- Line numbers and related settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "auto"

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Enable cursorline
vim.opt.cursorline = true

-- Word wrap
vim.opt.wrap = false

-- Disable swap and backup files, enable undofile
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath("data") .. "/site/undodir"
vim.opt.undofile = true

-- Search settings
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Enable termguicolors
vim.opt.termguicolors = true

-- Scrolling settings
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.isfname:append("@-@")

-- Set update time
vim.opt.updatetime = 750

-- Color column
vim.opt.colorcolumn = "80"

-- Syntax highlighting
vim.opt.syntax = "off"

-- Show command and mode in the status line
vim.opt.showcmd = true
vim.opt.showmode = false

-- General
vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Vim Commands
vim.cmd("set wildmenu")
