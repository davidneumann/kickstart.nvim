return {
	'echasnovski/mini.nvim',
	cond = false,
	version = '*',
	config = function()
		require("mini.animate").setup()
	end
}
