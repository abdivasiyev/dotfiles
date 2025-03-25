local leet = require('leetcode')

leet.setup {
	storage = {
		home = '~/Development/competitive/leetcode',
	}
}

vim.keymap.set('n', '<leader>lt', ':Leet test<cr>')

