local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>gr', builtin.lsp_references,{})
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations,{})

require('telescope').load_extension('media_files')

vim.keymap.set('n', '<leader>me', '<cmd>Telescope media_files<CR>')


require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            "node_modules",
            "target",
            "build",
            "windows",
            "linux",
            "ios",
            "macos"
        },
    }
}
