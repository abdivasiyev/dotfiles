require'nvim-treesitter.configs'.setup {
	ensure_installed = { 'bash', 'c', 'cpp', 'go', 'haskell', 'json', 'lua', 'make', 'markdown', 'php', 'python', 'rust', 'sql', 'vim', 'yaml' },
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}
