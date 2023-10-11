-- Clear guicursor
vim.opt.guicursor = ""

-- Line numbers and related settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"

-- Tab settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Word wrap
vim.opt.wrap = false

-- Disable swap and backup files, enable undofile
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('data') .. "/site/undodir"
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

-- Show command in the status line
vim.opt.showcmd = true

-- Clipboard settings
vim.opt.clipboard = "unnamedplus"

-- Enable wildmenu
vim.cmd('set wildmenu')
--statusline
vim.cmd "highlight StatusType guibg=#b16286 guifg=#1d2021"
vim.cmd "highlight StatusFile guibg=#fabd2f guifg=#1d2021"
vim.cmd "highlight StatusModified guibg=#1d2021 guifg=#d3869b"
vim.cmd "highlight StatusBuffer guibg=#98971a guifg=#1d2021"
vim.cmd "highlight StatusLocation guibg=#458588 guifg=#1d2021"
vim.cmd "highlight StatusPercent guibg=#1d2021 guifg=#ebdbb2"
vim.cmd "highlight StatusNorm guibg=none guifg=white"
vim.o.statusline = " "
				.. ""
				.. " "
				.. "%l"
				.. " "
				.. " %#StatusType#"
				.. "<< "
				.. "%Y"
				.. "  "
				.. " >>"
				.. "%#StatusFile#"
				.. "<< "
				.. "%F"
				.. " >>"
				.. "%#StatusModified#"
				.. " "
				.. "%m"
				.. " "
				.. "%#StatusNorm#"
				.. "%="
				.. "%#StatusBuffer#"
				.. "<< "
				.. "﬘ "
				.. "%n"
				.. " >>"
				.. "%#StatusLocation#"
				.. "<< "
				.. "燐 "
				.. "%l,%c"
				.. " >>"
				.. "%#StatusPercent#"
				.. "<< "
				.. "%p%%  "
				.. " >> "


