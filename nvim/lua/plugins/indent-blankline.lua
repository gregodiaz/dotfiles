return {
	"lukas-reineke/indent-blankline.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local ibl = require "ibl"
		local hooks = require "ibl.hooks"
		local highlight = { "Highlight" }

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "Highlight", { fg = "#e5c07b" })
		end)
		vim.g.rainbow_delimiters = { highlight = highlight }

		ibl.setup { scope = { highlight = highlight } }

		hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
	end,
}
