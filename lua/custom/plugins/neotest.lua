return {
	'nvim-neotest/neotest',
	dependencies = {
		'adrigzr/neotest-mocha',
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/neotest-go",
	},
	config = function()
		require('neotest').setup({
			adapters = {
				require('neotest-mocha')({
					command = "npm test --",
					env = { CI = true },
					cwd = function(path)
						return vim.fn.getcwd()
					end,
				}),
				require("neotest-go")
			}
		})
	end
}
