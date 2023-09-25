vim.cmd("highlight NetrwFile ctermfg=green")


vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Keymappings
vim.api.nvim_set_keymap('n', '<leader>du', ':Tex<CR>', { silent = true }) -- This duplicates the Current file/buffer
vim.api.nvim_set_keymap('n', '<leader><Up>', ':tabnext<CR>', { silent = true }) -- Similar to Ctrl + Tab
vim.api.nvim_set_keymap('n', '<leader><Down>', ':tabprevious<CR>', { silent = true }) -- Similar to Ctrl + Shift + Tab
vim.api.nvim_set_keymap('n', '<leader>tt', ':Lex<CR>', { silent = true }) --Toggle tree
