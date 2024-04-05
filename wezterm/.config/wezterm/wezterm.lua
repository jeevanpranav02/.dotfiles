local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("Fira Code")
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
})
-- Set background to same color as neovim
config.colors = {}
config.colors.background = "#111111"

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.enable_tab_bar = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

return config
