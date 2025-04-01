-- get left side of the diff
vim.keymap.set('n', 'dh', ':diffget //2<CR>')
-- get right side of the diff
vim.keymap.set('n', 'dl', ':diffget //3<CR>')
-- get both sides of the diff
vim.keymap.set('n', 'gj', ':diffget //1<CR>')
-- open fugitive status
vim.keymap.set('n', '<leader>gg', ':G<CR>')
