-- Enable spell check
vim.opt_local.spell = true
vim.opt_local.wrap = true
vim.opt_local.conceallevel = 3

require "ibl".overwrite {
    exclude = { filetypes = { 'norg' } }
}
