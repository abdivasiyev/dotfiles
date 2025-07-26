return {
	{
		'tanvirtin/vgit.nvim',
		dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
		-- Lazy loading on 'VimEnter' event is necessary.
		event = 'VimEnter',
		config = function()
			require("vgit").setup()

			vim.opt.statusline:append("%{get(b:,'vgit_status','')}")
		end,
		keys = {
			{
				"<leader>gg",
				function()
					require("vgit").project_diff_preview()
				end,
				desc = "Open VGit Diff",
			},
		},
	}
}
