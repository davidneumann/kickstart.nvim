return {
	"nvim-telescope/telescope-smart-history.nvim",
	dependencies = {
		'nvim-telescope/telescope.nvim'
	},
	config = function()
		require('telescope').load_extension('smart_history')
	end
}
