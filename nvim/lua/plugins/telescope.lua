return {
	{
		'nvim-telescope/telescope.nvim',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{ 'jonarrien/telescope-cmdline.nvim' },
			{ 'nvim-telescope/telescope-file-browser.nvim' },
		},
		lazy = true,
		keys = {
			{ '<leader>ff',   require('telescope.builtin').find_files,                desc = 'Find files' },
			{ '<leader>fb',   require('telescope.builtin').buffers,                   desc = 'Find buffers' },
			{ '<leader>fg',   require('telescope.builtin').live_grep,                 desc = 'Live grep' },
			{ '<leader>cs',   require('telescope.builtin').colorscheme,               desc = 'Colorscheme' },
			{ '/',            require('telescope.builtin').current_buffer_fuzzy_find, desc = 'Fuzzy find in current buffer' },
			{ '<leader>gbc',  require('telescope.builtin').git_bcommits,              desc = 'Git buffer commits' },
			{ '<leader>gbl',  require('telescope.builtin').git_branches,              desc = 'Git branches' },
			{ '<leader>gbb',  '<cmd>:G blame<cr>',                                    desc = 'Git blame' },
			{ '<leader>lds',  require('telescope.builtin').lsp_document_symbols,      desc = 'LSP document symbols' },
			{ '<leader>todo', '<cmd>:TodoTelescope<cr>',                              desc = 'Todo Telescope' },
		},
	}
}
