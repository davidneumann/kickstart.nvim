return {
	"danymat/neogen",
	config = function ()
		require('neogen').setup({})
		require('neogen').setup({ snippet_engine = "luasnip" })
	end,
	-- Uncomment next line if you want to follow only stable versions
	-- version = "*"
	keys = {
		{ "<leader>cD", ":lua require('neogen').generate()<cr>", desc = "[C]ode Generate [D]ocs"}
	}
}
