-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

require("nvim-tree").setup({
	sort = {
		sorter = "case_sensitive",
	},
	view = {
		width = 30,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		enable = false,
	},
	update_focused_file = {
		enable = true,
	},
})

vim.keymap.set("n", '<leader><s-p>', ":NvimTreeToggle<CR>")
