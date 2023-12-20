vim.cmd.highlight("clear")
if vim.g.syntax_on then
	vim.cmd.syntax("reset")
end

if not pcall(require, "colorbuddy") then
	return
end

-- This will clear the style italic and set it to none
-- if vim.env.USER == "jp" then
-- 	rawset(require("colorbuddy").styles, "italic", require("colorbuddy").styles.none)
-- end
require("colorbuddy").colorscheme("gruvbuddy")

local c = require("colorbuddy.color").colors
local Group = require("colorbuddy.group").Group
local g = require("colorbuddy.group").groups
local s = require("colorbuddy.style").styles

Group.new("@variable", c.superwhite, nil, s.italic)

Group.new("GoTestSuccess", c.green, nil, s.bold)
Group.new("GoTestFail", c.red, nil, s.bold)

-- Group.new("Keyword", c.purple, nil, nil)

Group.new("TSPunctBracket", c.orange:light():light())

Group.new("StatuslineError1", c.red:light():light(), g.Statusline)
Group.new("StatuslineError2", c.red:light(), g.Statusline)
Group.new("StatuslineError3", c.red, g.Statusline)
Group.new("StatuslineError3", c.red:dark(), g.Statusline)
Group.new("StatuslineError3", c.red:dark():dark(), g.Statusline)

Group.new("pythonTSType", c.red)
Group.new("goTSType", g.Type.fg:dark(), nil, g.Type)

Group.new("typescriptTSConstructor", g.pythonTSType)
Group.new("typescriptTSProperty", c.blue)

-- vim.cmd [[highlight WinSeparator guifg=#4e545c guibg=None]]
Group.new("WinSeparator", nil, nil)

-- I don't think I like highlights for text
-- Group.new("LspReferenceText", nil, c.gray0:light(), s.bold)
-- Group.new("LspReferenceWrite", nil, c.gray0:light())

-- Group.new("TSKeyword", c.purple, nil, s.underline, c.blue)
-- Group.new("LuaFunctionCall", c.green, nil, s.underline + s.nocombine, g.TSKeyword.guisp)

Group.new("TSTitle", c.blue)

-- TODO: It would be nice if we could only highlight
-- the text with characters or something like that...
-- but we'll have to stick to that for later.
Group.new("InjectedLanguage", nil, g.Normal.bg:dark())

Group.new("LspParameter", nil, nil, s.italic)
Group.new("LspDeprecated", nil, nil, s.strikethrough)
Group.new("@function.bracket", g.Normal, g.Normal)
Group.new("@variable.builtin", c.purple:light():light(), g.Normal)

-- Group.new("VirtNonText", c.yellow:light():light(), nil, s.italic)
Group.new("VirtNonText", c.gray3:dark(), nil, s.italic)

Group.new("TreesitterContext", nil, g.Normal.bg:light())
Group.new("TreesitterContextLineNumber", c.blue)
-- hi TreesitterContextBottom gui=underline guisp=Grey
-- Group.new("TreesitterContextBottom", nil, nil, s.underline)

Group.new("@property", c.blue)
Group.new("@punctuation.bracket.rapper", c.gray3, nil, s.none)
Group.new("@rapper_argument", c.red, nil, s.italic)
Group.new("@rapper_return", c.orange:light(), nil, s.italic)
Group.new("@constructor.ocaml", c.orange:light(), nil, s.none)
Group.new("constant", c.orange, nil, s.none)
Group.new("@comment", c.gray3, nil, s.italic)
Group.new("@punctuation.bracket", c.gray2:light(), nil, s.bold)

Group.new("@keyword", c.blue, nil, s.italic)
Group.new("@keyword.faded", g.nontext.fg:light(), nil, s.none)
-- Group.new("@keyword.faded", c.green)

Group.new("Function", c.yellow, nil, s.none)
Group.new("TabLineFill", nil, nil)

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

Group.new("Normal", c.superwhite, nil)
Group.new("NormalFloat", c.superwhite, nil)
Group.new("LineNr", c.gray3, nil)
Group.new("SignColumn", c.superwhite, nil)

-- Completion
Group.new("CmpItemAbbr", g.Comment)
Group.new("CmpItemAbbrDeprecated", g.Error)
Group.new("CmpItemAbbrMatchFuzzy", g.CmpItemAbbr.fg:dark(), nil, s.italic)
Group.new("CmpItemKind", g.Special)
Group.new("CmpItemMenu", g.NonText)
