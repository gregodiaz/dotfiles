return {
	-- "luisiacc/gruvbox-baby",
	"olimorris/onedarkpro.nvim",
	priority = 1000,
	lazy = false,
	config = function()
		require("onedarkpro").setup({
			styles = {
				comments = "bold, italic",
				methods = "bold, italic",
				keywords = "italic",
				functions = "bold, italic",
				conditionals = "italic",
			},
			options = {
				cursorline = true,
				transparency = false,
				terminal_colors = true,
				highlight_inactive_windows = true,
			}
		})
		vim.cmd.colorscheme "onedark"
	end,
}
