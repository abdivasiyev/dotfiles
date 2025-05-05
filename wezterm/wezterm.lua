local wezterm = require("wezterm")
local config = {
	enable_tab_bar = false,
	color_scheme = "Gruvbox dark, hard (base16)",
	font = wezterm.font("JetBrains Mono"),
	font_size = 18.0,
	term = "xterm-256color",
	window_padding = {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0,
	},
}

return config
