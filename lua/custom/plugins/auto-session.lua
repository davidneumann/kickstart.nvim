function _G.close_all_floating_wins()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local config = vim.api.nvim_win_get_config(win)
		if config.relative ~= '' then
			vim.api.nvim_win_close(win, false)
		end
	end

	-- local api = require("nvim-tree.api")
	-- api.tree.close()
end

return {
	'rmagatti/auto-session',
	config = function()
		require('auto-session').setup {
			log_level = "error",
			pre_save_cmds = { _G.close_all_floating_wins },
		}
	end
}
