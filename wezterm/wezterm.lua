local wezterm = require("wezterm")
local config = {
	enable_tab_bar = false,
	-- color_scheme = "Catppuccin Mocha",
	font = wezterm.font("JetBrains Mono"),
	font_size = 18.0,
	window_background_image = os.getenv("HOME") .. "/.config/wezterm/bg/bg.png",
	window_background_opacity = 0.5,
	term = "xterm-256color",
}

return config
