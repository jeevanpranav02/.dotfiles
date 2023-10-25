local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pg', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, {})

require('telescope').load_extension('media_files')
require('telescope').load_extension('harpoon')
require('telescope').load_extension('neoclip')
require('telescope').load_extension('flutter')
require('telescope').load_extension('dap')

vim.keymap.set('n', '<leader>pm', '<cmd>Telescope media_files<CR>')
vim.keymap.set('n', '<leader>pd', '<cmd>Telescope diagnostics<CR>')
vim.keymap.set('n', '<leader>=', '<cmd>Telescope registers<CR>')
vim.keymap.set('n', '<leader>fr', '<cmd>Telescope flutter commands<CR>')

require('telescope').setup {
    defaults = {
        winblend = 20,
        prompt_position = "top",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        file_ignore_patterns = {
            "node_modules",
            "target",
            "build",
            "windows",
            "linux",
            "ios",
            "macos",
            "vendor"
        },
        initial_mode = "normal",
        vertical = { width = 0.8, },
    },
    pickers = {
        find_files = {
            theme = "dropdown",
            previewer = false,
        },
        grep_string = {
            -- theme = "dropdown",
        },
        git_files = {
            -- theme = "dropdown",
            -- previewer = false,
            winblend = 40,
            layout_options = {
                max_results = 10,
                preview_width = 0.8,
            },
        },
    },
    extensions = {
        "media_files",
        "fzf",
        "file_browser",
        "harpoon",
        "neoclip",
        media_files = {
            -- filetypes whitelist
            -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
            filetypes = { "svg", "png", "webp", "jpg", "jpeg" },
            -- find command (defaults to `fd`)
            find_cmd = "rg"
        }
    }
}
