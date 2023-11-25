return {
	{
		"Asheq/close-buffers.vim",
		event = "VeryLazy",
		keys = {
			{
				"<leader>bo",
				"<cmd>Bdelete hidden<cr>",
				desc = "[B]uffer Close [H]idden",
				mode = { "n", "v" },
			},
		},
	},
}
