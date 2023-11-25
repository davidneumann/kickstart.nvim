return {
	'akinsho/bufferline.nvim',
	version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		local bufferline = require('bufferline')
		bufferline.setup {
			options = {
				mode = "buffers",                                -- set to "tabs" to only show tabpages instead
				style_preset = bufferline.style_preset.padded_slant, -- or bufferline.style_preset.minimal,
				themable = true,
				numbers = "ordinal",
				diagnostics = "nvim_lsp",
				diagnostics_update_in_insert = true,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true
					}
				},
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
				separator_style = "slant",
				always_show_bufferline = true,
				hover = {
					enabled = true,
					delay = 200,
					reveal = { 'close' }
				},
				sort_by = 'insert_after_current',
			}
		}
	end
}
