return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"fredrikaverpil/neotest-golang",
			"andythigpen/nvim-coverage",
		},
		lazy = true,
		config = function()
			local neotest = require('neotest')
			local coverage = require('coverage')

			coverage.setup({
				auto_reload = true,
			})

			neotest.setup({
				adapters = {
					require('neotest-golang')({
						runner = "go",
						go_test_args = {
							"-v",
							"-race",
							"-count=1",
							"-coverprofile=" .. vim.fn.getcwd() .. "/coverage.out",
						},
					}),
				},
			})
		end,
		keys = {
			{ "<leader>ta", function() require('neotest').run.attach() end },
			{ "<leader>tf", function() require('neotest').run.run(vim.fn.expand("%")) end },
			{ "<leader>tA", function() require('neotest').run.run(vim.uv.cwd()) end },
			{ "<leader>tS", function() require('neotest').run.run({ suite = true }) end },
			{ "<leader>tn", function() require('neotest').run.run() end },
			{ "<leader>tl", function() require('neotest').run.run_last() end },
			{ "<leader>ts", function() require('neotest').summary.toggle() end },
			{ "<leader>to", function() require('neotest').output.open({ enter = true, auto_close = true }) end },
			{ "<leader>tO", function() require('neotest').output_panel.toggle() end },
			{ "<leader>tp", function() require('neotest').run.stop() end },
			{ "<leader>td", function() require('neotest').run.run({ suite = false, strategy = "dap" }) end },
			{ "<leader>tD", function() require('neotest').run.run({ vim.fn.expand("%"), strategy = "dap" }) end },
			{ "<leader>tc", ":Coverage<cr>:CoverageSummary<cr>" },
		},
	}
}
