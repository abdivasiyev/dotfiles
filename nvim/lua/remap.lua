vim.g.mapleader = ' '

-- back to directory tree
-- vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- move selection up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- up or down buffer
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- exit from terminal mode using <ESC>
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- open terminal in normal mode
vim.keymap.set("n", "<leader>tt", ":terminal<CR>")

-- indent selection
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- switch buffer
vim.keymap.set("n", "<TAB>", ":bn<CR>")
vim.keymap.set("n", "<S-TAB>", ":bp<CR>")
vim.keymap.set("n", "<leader>bd", ":bd<CR>")

-- show lsp errors on float window
vim.keymap.set("n", "<leader>e", ":lua vim.diagnostic.open_float(0, {scope='line'})<CR>")
