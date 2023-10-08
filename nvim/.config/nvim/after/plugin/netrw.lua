vim.cmd("highlight NetrwFile ctermfg=green")

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 0

-- Keymappings
vim.api.nvim_set_keymap('n', '<leader>du', ':Tex<CR>', { silent = true }) -- This duplicates the Current file/buffer
vim.api.nvim_set_keymap('n', '<leader><Up>', ':tabnext<CR>', { silent = true }) -- Similar to Ctrl + Tab
vim.api.nvim_set_keymap('n', '<leader><Down>', ':tabprevious<CR>', { silent = true }) -- Similar to Ctrl + Shift + Tab
vim.api.nvim_set_keymap('n', '<leader>q', ':Lex<CR>', { silent = true }) --Toggle tree

-- Turns off netrw
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.loaded_netrwSettings = 1
-- vim.g.loaded_netrwFileHandlers = 1
-- -- set termguicolors to enable highlight groups
-- vim.opt.termguicolors = true
