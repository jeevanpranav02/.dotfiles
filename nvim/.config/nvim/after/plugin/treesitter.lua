require('nvim-treesitter.configs').setup {
    ensure_installed = { "java", "html", "json", "css", "javascript", "typescript", "rust", "lua", "vim", "vimdoc",
        "query", "cmake", "c", "dart", "bash" },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.blade = {
    install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
    },
    filetype = "blade"
}

vim.filetype.add({
    pattern = {
        ['.*%.blade%.php'] = 'blade',
    },
})
