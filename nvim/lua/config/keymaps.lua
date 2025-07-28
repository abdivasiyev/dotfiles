vim.g.mapleader = ' '
vim.g.localleader = '  '

local keymap = vim.keymap

-- back to directory tree
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move selection up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- up or down buffer
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- exit from terminal mode using <ESC>
keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- open terminal in normal mode
keymap.set("n", "<leader>tt", ":terminal<CR>")

-- indent selection
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

-- switch buffer
keymap.set("n", "<TAB>", ":bn<CR>")
keymap.set("n", "<S-TAB>", ":bp<CR>")
keymap.set("n", "<leader>bd", ":bd<CR>")

-- show lsp errors on float window
keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float(0, {scope='line'})<CR>")

keymap.set("i", "<Tab>", function()
	return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>"
end, { expr = true })

keymap.set("i", "<S-Tab>", function()
	return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>"
end, { expr = true })

keymap.set("i", "<CR>", function()
	return vim.fn.pumvisible() == 1 and "<C-y>" or "<CR>"
end, { expr = true })
