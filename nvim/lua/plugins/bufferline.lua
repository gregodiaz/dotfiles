return {
	'akinsho/bufferline.nvim',
	version = 'v3.*',
	dependencies = "kyazdani42/nvim-web-devicons",
	opts = {
		options = {
			numbers = 'ordinal',
			right_mouse_command = "bdelete! %d",
			left_mouse_command = "buffer %d",
			indicator = {
				icon = '',
				style = 'icon',
			},
			diagnostics = "nvim_lsp",
			diagnostics_update_in_insert = true,
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icon = level:match("error") and " " or level:match("warning") and " " or " "
				return " " .. icon .. count
			end,
			offsets = {
				{
					filetype = "neo-tree",
					text = "File Explorer",
					text_align = "left",
					separator = true
				}
			},
			separator_style = "slope", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
			enforce_regular_tabs = true,
		}
	}
}
