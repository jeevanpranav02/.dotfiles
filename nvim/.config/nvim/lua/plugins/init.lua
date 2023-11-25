print("Hello from custom.plugin")

-- Core Plugins
require("plugins.core.fugitive")
require("plugins.core.harpoon")
require("plugins.core.telescope")
require("plugins.core.treesitter")

-- Language Server Config
require("plugins.lsp")

-- Linter Config
require("plugins.linter")

-- Formatter Config
require("plugins.formatter")

-- Snippet Config
require("plugins.luasnip")

-- Diagnostics
require("plugins.trouble")

-- Debug Adapter Config
require("plugins.dap")

-- Editor UI Config
require("plugins.editor.dressing")
require("plugins.editor.colors")
require("plugins.editor.filetree")
require("plugins.editor.colorizer")
require("plugins.editor.toggleterm")
require("plugins.editor.autopairs")

-- Addition Goodtohave Plugins
require("plugins.extra.comment")
require("plugins.extra.neorg")
require("plugins.extra.undotree")
require("plugins.extra.zenmode")
require("plugins.extra.statusline")
