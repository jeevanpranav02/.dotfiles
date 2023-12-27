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
vim.opt.inccommand = "split"
vim.opt.ignorecase = true

-- Enable termguicolors
vim.opt.termguicolors = true

-- Scrolling settings
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.isfname:append("@-@")

-- Set update time
vim.opt.updatetime = 50

-- Color column
vim.opt.colorcolumn = "80"

-- Syntax highlighting
vim.opt.syntax = "off"

-- Show command and mode in the status line
vim.opt.showcmd = true
vim.opt.showmode = false

-- General
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.mouse = "a" -- allow the mouse to be used in neovim

-- search files into subfolders
-- provides tab-complete for all files
-- by default we had `/usr/include` in here, which we don't need
vim.opt.path = { ".", "**" }
-- vim wildignore. Used for path autocomplete and `gf`.
vim.opt.wildignore:append({
	"*/.git/", -- I might have to remove this when fugitive has problems
	"*/__pycache__/",
	"*/.direnv/",
	"*/node_modules/",
	"*/.pytest_cache/",
	"*/.mypy_cache/",
	"*/target/", -- rust target directory
	"tags",
})
-- show all options when tab-completing
vim.opt.wildmenu = true

-- Clipboard
-- vim.opt.clipboard = "unnamedplus"

-- VirtualEdit
vim.opt.virtualedit = "block"
