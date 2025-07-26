return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = true,
		config = function()
			require("nvim-treesitter.configs").setup({
				modules = {},
				ensure_installed = { "haskell", "go", "lua", "yaml" }, -- your languages here
				sync_install = false,
				auto_install = true,
				ignore_install = {},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
				incremental_selection = {
					enable = true,
				},
			})
		end,
	}
}
