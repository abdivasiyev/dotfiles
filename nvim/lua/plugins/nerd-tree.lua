return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		lazy = true,
		keys = {
			{ "<leader><s-p>", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree" },
		},
		config = function()
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
		end
	}
}
