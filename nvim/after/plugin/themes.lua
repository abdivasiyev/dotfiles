-- vim.cmd.colorscheme "retrobox"
-- vim.cmd.colorscheme "kanagawa"

-- require('cyberdream').setup {
-- 	transparent = true,
-- }
--
-- vim.cmd.colorscheme "cyberdream"
--
-- Default options:
require("gruvbox").setup({
	terminal_colors = true, -- add neovim terminal colors
	undercurl = true,
	underline = true,
	bold = true,
	italic = {
		strings = true,
		emphasis = true,
		comments = true,
		operators = false,
		folds = true,
	},
	strikethrough = true,
	invert_selection = false,
	invert_signs = false,
	invert_tabline = false,
	invert_intend_guides = false,
	inverse = true, -- invert background for search, diffs, statuslines and errors
	contrast = "soft", -- can be "hard", "soft" or empty string
	palette_overrides = {},
	overrides = {},
	dim_inactive = false,
	transparent_mode = true,
})

vim.o.background = "dark"
vim.cmd.colorscheme "gruvbox"
