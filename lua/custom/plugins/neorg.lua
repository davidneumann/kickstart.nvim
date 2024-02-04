vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = "*.norg",
	command = "set conceallevel=3"
})

return {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("neorg").setup {
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				[ "core.export" ] = {},
				["core.concealer"] = {
					config = {
						folds = false,

					}
				}, -- Adds pretty icons to your documents
				["core.completion"] = {
					config = {
						engine = "nvim-cmp"
					}
				},
				["core.journal"] = {

				},
				["core.summary"] = {},
				["core.dirman"] = { -- Manages Neorg workspaces
					config = {
						workspaces = {
							notes = "~/notes",
							journal = "~/notes/journal"
						},
						default_workspace = "notes"
					},
				},
			},
		}
	end,
}
