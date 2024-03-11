local _enable_lazy = { true, true, true, false }
return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = _enable_lazy[1],
		config = function()
			if not pcall(require, "rose-pine") then
				return
			end
			require("rose-pine").setup({
				disable_background = true,
				disable_float_background = true,
				disable_italics = true,
			})
			ColorMyPencils("rose-pine")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = _enable_lazy[2],
		config = function()
			if not pcall(require, "catppuccin") then
				return
			end
			require("catppuccin").setup({
				transparent_background = true,
			})
			ColorMyPencils("catppuccin")
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = _enable_lazy[3],
		config = function()
			if not pcall(require, "tokyonight") then
				return
			end
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				transparent = true,
			})
			ColorMyPencils("tokyonight")
		end,
	},
	{
		"tjdevries/colorbuddy.vim",
		lazy = _enable_lazy[4],
		dependencies = { "tjdevries/gruvbuddy.nvim" },
		config = function()
			vim.cmd.highlight("clear")
			if vim.g.syntax_on then
				vim.cmd.syntax("reset")
			end

			if not pcall(require, "colorbuddy") then
				return
			end

			-- This will clear the style italic and set it to none
			-- if vim.env.USER == "jp" then
			--     rawset(require("colorbuddy").styles, "italic", require("colorbuddy").styles.none)
			-- end
			require("colorbuddy").colorscheme("gruvbuddy")

			local colors = require("colorbuddy.color").colors
			local Group = require("colorbuddy.group").Group
			local groups = require("colorbuddy.group").groups
			local styles = require("colorbuddy.style").styles
			local Color = require("colorbuddy.color").Color

			-- Custom Colors
			Color.new("skyblue", "#569CD6")
			Color.new("lightblue", "#9CDCFE")
			Color.new("pink", "#C586C0")
			Color.new("front", "#D4D4D4")

			--  Random Stuff
			Group.new("GoTestSuccess", colors.green, nil, styles.bold)
			Group.new("GoTestFail", colors.red, nil, styles.bold)

			Group.new("TSPunctBracket", colors.orange:light():light())

			Group.new("StatuslineError1", colors.red:light():light(), groups.Statusline)
			Group.new("StatuslineError2", colors.red:light(), groups.Statusline)
			Group.new("StatuslineError3", colors.red, groups.Statusline)
			Group.new("StatuslineError3", colors.red:dark(), groups.Statusline)
			Group.new("StatuslineError3", colors.red:dark():dark(), groups.Statusline)

			Group.new("pythonTSType", colors.red)
			Group.new("goTSType", groups.Type.fg:dark(), nil, groups.Type)

			Group.new("typescriptTSConstructor", groups.pythonTSType)
			Group.new("typescriptTSProperty", colors.blue)

			-- vim.cmd [[highlight WinSeparator guifg=#4e545c guibg=None]]
			Group.new("WinSeparator", nil, nil)

			-- I don't think I like highlights for text
			-- Group.new("LspReferenceText"  , nil , colors.gray0:light()  , styles.bold)
			-- Group.new("LspReferenceWrite" , nil , colors.gray0:light())

			-- Group.new("TSKeyword"       , c.purple , nil , s.underline               , c.blue)
			-- Group.new("LuaFunctionCall" , c.green  , nil , s.underline + s.nocombine , g.TSKeyword.guisp)

			Group.new("TSTitle", colors.blue)

			-- TODO: It would be nice if we could only highlight
			-- the text with characters or something like that...
			-- but we'll have to stick to that for later.
			Group.new("InjectedLanguage", nil, groups.Normal.bg:dark())

			Group.new("LspParameter", nil, nil, styles.italic)
			Group.new("LspDeprecated", nil, nil, styles.strikethrough)

			-- Group.new("VirtNonText" , c.yellow:light():light() , nil , s.italic)
			Group.new("VirtNonText", colors.gray3:dark(), nil, styles.italic)

			Group.new("TreesitterContext", nil, groups.Normal.bg:light())
			Group.new("TreesitterContextLineNumber", colors.blue)
			-- hi TreesitterContextBottom gui=underline guisp=Grey
			-- Group.new("TreesitterContextBottom" , nil , nil , s.underline)

			Group.new("@variable", colors.superwhite, nil, styles.italic)
			Group.new("@property", colors.blue)
			Group.new("@punctuation.bracket.rapper", colors.gray3, nil, styles.none)
			Group.new("@rapper_argument", colors.red, nil, styles.italic)
			Group.new("@rapper_return", colors.orange:light(), nil, styles.italic)
			Group.new("@constructor.ocaml", colors.orange:light(), nil, styles.none)
			Group.new("constant", colors.orange, nil, styles.none)
			Group.new("@comment", colors.gray3, nil, styles.italic)
			Group.new("@punctuation.bracket", colors.gray2:light(), nil, styles.bold)
			Group.new("@operator", colors.superwhite)
			Group.new("@attribute", colors.superwhite)
			Group.new("@keyword", colors.purple, nil, styles.none)
			-- Group.new("@keyword.faded"           , groups.nontext.fg:light() , nil , styles.none)
			-- Group.new("@keyword.faded"           , c.green)

			Group.new("@function.bracket", groups.Normal, groups.Normal)
			Group.new("@variable.builtin", colors.purple:light():light(), groups.Normal)

			Group.new("Function", colors.yellow, nil, styles.none)
			Group.new("TabLineFill", nil, nil)

			-- General Stuff
			Group.new("Normal", colors.superwhite, nil)
			Group.new("NormalFloat", colors.superwhite, nil)
			Group.new("LineNr", colors.gray3, nil)
			Group.new("SignColumn", colors.superwhite, nil)
			Group.new("ColorColumn", nil, colors.gray2)
			Group.new("Folded", colors.gray3, nil)

			-- Completion -- cmp-nvim
			Group.new("CmpItemAbbr", groups.Comment)
			Group.new("CmpItemAbbrDeprecated", groups.Error)
			Group.new("CmpItemAbbrMatch", colors.pink, nil)
			Group.new("CmpItemAbbrMatchFuzzy", groups.CmpItemAbbr.fg:dark(), nil, styles.italic)
			Group.new("CmpItemMenu", groups.NonText)
			Group.new("CmpItemKind", groups.Special)
			-- Group.new("CmpItemKindVariable", colors.skyblue)
			-- Group.new("CmpItemKindFunction", colors.lightblue)
			-- Group.new("CmpItemKindKeyword", colors.pink)
			-- Group.new("CmpItemKindProperty", colors.front)
			-- Group.new("CmpItemKindUnit", colors.superwhite)

			-- Harpoon
			Group.new("HarpoonWindow", colors.superwhite, nil)
			Group.new("HarpoonBorder", colors.gray3, nil)
			Group.new("HarpoonTitle", colors.gray3, nil)

			-- GitSigns
			Group.new("GitSignsAdd", colors.green:dark(), nil)
			Group.new("GitSignsChange", colors.orange:light(), nil)
			Group.new("GitSignsDelete", colors.red:light(), nil)
			Group.new("GitSignsUntracked", colors.blue:light(), nil)

			-- Linking stuff
			vim.cmd([[
	           hi link @function.call.lua LuaFunctionCall
	           hi link @lsp.type.variable.lua variable
	           hi link @lsp.type.variable.ocaml variable
	           hi link @lsp.type.variable.rust variable
	           hi link @lsp.type.namespace @namespace
	           hi link @lsp.type.comment @comment
	           hi link @punctuation.bracket.rapper @text.literal
	           hi link @normal Normal
	           hi link CurSearch IncSearch
	           hi link diffAdded DiffAdd
	           hi link diffChanged DiffChange
	           hi link diffRemoved DiffDelete
	           hi link StatusLineTerm StatusLine
	           hi link StatusLineTermNC StatusLineNC
	           hi link WildMenu IncSearch
	           hi link Typedef Type
	           hi link markdownH1Delimiter markdownH1
	           hi link markdownH2Delimiter markdownH2
	           hi link markdownH3Delimiter markdownH3
	           hi link markdownH4Delimiter markdownH4
	           hi link markdownH5Delimiter markdownH5
	           hi link markdownH6Delimiter markdownH6
	           hi link markdownUrl markdownLinkText
	           hi link mkdLink mkdInlineURL
	           hi link mkdLinkDef mkdInlineURL
	           hi link mkdURL mkdInlineURL
	           hi link @boolean Boolean
	           hi link @character Character
	           hi link @character.special @character
	           hi link @comment Comment
	           hi link @conditional Conditional
	           hi link @constant Constant
	           hi link @constant.macro @constant
	           hi link @function Function
	           hi link @function.macro @function
	           hi link @include Include
	           hi link @keyword Keyword
	           hi link @label Label
	           hi link @macro Macro
	           hi link @number Number
	           hi link @operator Operator
	           hi link @preproc PreProc
	           hi link @punctuation.bracket @punctuation
	           hi link @punctuation.delimiter @punctuation
	           hi link @punctuation.special @punctuation
	           hi link @regexp String
	           hi link @repeat Repeat
	           hi link @storageclass StorageClass
	           hi link @string String
	           hi link @string.special @string
	           hi link @symbol Identifier
	           hi link @tag Tag
	           hi link @text.math Special
	           hi link @text.environment Macro
	           hi link @text.environment.name Type
	           hi link @text.title Title
	           hi link @text.note SpecialComment
	           hi link @todo Todo
	           hi link @type Type
	           hi link @namespace @include
	           hi link @lsp.type.enum @type
	           hi link @lsp.type.keyword @keyword
	           hi link @lsp.type.interface @interface
	           hi link @lsp.type.namespace @namespace
	           hi link @lsp.type.parameter @parameter
	           hi link @lsp.type.property @property
	           hi link @lsp.typemod.function.defaultLibrary Special
	           hi link @lsp.typemod.variable.defaultLibrary @variable.builtin
	           hi link @lsp.typemod.operator.injected @operator
	           hi link @lsp.typemod.string.injected @string
	           hi link @lsp.typemod.variable.injected @variable
	           hi link @text.title.1.markdown markdownH1
	           hi link @text.title.1.marker.markdown markdownH1Delimiter
	           hi link @text.title.2.markdown markdownH2
	           hi link @text.title.2.marker.markdown markdownH2Delimiter
	           hi link @text.title.3.markdown markdownH3
	           hi link @text.title.3.marker.markdown markdownH3Delimiter
	           hi link @text.title.4.markdown markdownH4
	           hi link @text.title.4.marker.markdown markdownH4Delimiter
	           hi link @text.title.5.markdown markdownH5
	           hi link @text.title.5.marker.markdown markdownH5Delimiter
	           hi link @text.title.6.markdown markdownH6
	           hi link @text.title.6.marker.markdown markdownH6Delimiter
	           hi link SignAdd GitSignsAdd
	           hi link SignChange GitSignsChange
	           hi link SignDelete GitSignsDelete
	           hi link NvimTreeOpenedFolderName NvimTreeFolderName
	           hi link NvimTreeSpecialFile NvimTreeNormal
	           hi link NeorgHeading1Title NeorgHeading1Prefix
	           hi link NeorgHeading2Title NeorgHeading2Prefix
	           hi link NeorgHeading3Title NeorgHeading3Prefix
	           hi link NeorgHeading4Title NeorgHeading4Prefix
	           hi link NeorgHeading5Title NeorgHeading5Prefix
	           hi link NeorgHeading6Title NeorgHeading6Prefix
	           hi link DapUIVariable Normal
	           hi link DapUIValue Normal
	           hi link DapUIFrameName Normal
	           hi link DapUIWatchesValue DapUIThread
	           hi link DapUIBreakpointsInfo DapUIThread
	           hi link DapUIWatchesError DapUIWatchesEmpty
	           hi link DapUIScope DapUIBreakpointsPath
	           hi link DapUILineNumber DapUIBreakpointsPath
	           hi link DapUIBreakpointsLine DapUIBreakpointsPath
	           hi link DapUIFloatBorder DapUIBreakpointsPath
	           hi link DapUIStoppedThread DapUIBreakpointsPath
	           hi link DapUIDecoration DapUIBreakpointsPath
	           ]])
		end,
	},
}
