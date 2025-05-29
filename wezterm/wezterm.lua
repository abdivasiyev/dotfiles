local wezterm = require("wezterm")

---@enum (key) Mode
local theme = {
	light = "Google Light (Gogh)",
	dark = "Google Dark (Gogh)",
}

---@return Mode
local detect = function()
	if wezterm.gui and wezterm.gui.get_appearance():find("Light") then
		return "light"
	end
	return "dark"
end

local config = {
	enable_tab_bar = false,
	color_scheme = theme['dark'],
	font = wezterm.font("JetBrains Mono"),
	font_size = 14.0,
	term = "xterm-256color",
	background = {
		{
			source = {
				Color = "black",
			},
			width = "100%",
			height = "100%",
		},
		{
			source = {
				File = wezterm.home_dir .. "/.config/wezterm/background.jpg",
			},
			hsb = {
				brightness = 0.05,
				hue = 1.0,
				saturation = 1.0,
			},
		},
	},
	window_padding = {
		top = 0,
		bottom = 0,
		left = 0,
		right = 0,
	},
}

return config
