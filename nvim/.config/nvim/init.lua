---@diagnostic disable: undefined-global
require("jb.globals")
require("jb.set")
require("jb.autocmds")
require("jb.remap")

-- Core Plugins
Spec("plugins.core.treesitter")
Spec("plugins.core.telescope")
Spec("plugins.core.harpoon")
Spec("plugins.core.tpope")

-- Debugger
Spec("plugins.dap")

-- LSP
Spec("plugins.lsp")

-- Language Plugins
Spec("plugins.lsp.lang.c_sharp")
Spec("plugins.lsp.lang.flutter")
Spec("plugins.lsp.lang.java")
Spec("plugins.lsp.lang.json")
Spec("plugins.lsp.lang.lua")
Spec("plugins.lsp.lang.php")
Spec("plugins.lsp.lang.python")
Spec("plugins.lsp.lang.rust")
Spec("plugins.lsp.lang.tailwind")
Spec("plugins.lsp.lang.yaml")

-- Editor Plugins
Spec("plugins.editor.colors")
Spec("plugins.editor.tabline")
Spec("plugins.editor.autopairs")
Spec("plugins.editor.colorizer")
Spec("plugins.editor.filetree")
Spec("plugins.editor.toggleterm")

-- UI Plugins
Spec("plugins.formatter")
Spec("plugins.linter")
Spec("plugins.luasnip")
Spec("plugins.trouble")

-- Extra Plugins
Spec("plugins.extra")

if vim.g.neovide then
	vim.o.guifont = "Fira Code:h9"
	vim.opt.linespace = 0
	vim.g.neovide_scale_factor = 1.0
	-- Helper function for transparency formatting
	local alpha = function()
		return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
	end
	-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
	vim.g.neovide_transparency = 0.85
	vim.g.transparency = 0.2
	vim.g.neovide_background_color = "#0f1117" .. alpha()

	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_hide_mouse_when_typing = true
end

require("jb.lazy")
