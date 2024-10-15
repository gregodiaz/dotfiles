return {
	'stevearc/oil.nvim',
	dependencies = { "kyazdani42/nvim-web-devicons" },
	keys = { { "-", ":Oil --float<CR>" } },
	opts = {
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true,
		},
		float = {
			padding = 3,
		},
		cleanup_delay_ms = 500,
		-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
		-- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
		-- Additionally, if it is a string that matches "actions.<name>",
		-- it will use the mapping at require("oil.actions").<name>
		-- Set to `false` to remove a keymap
		-- See :help oil-actions for a list of all available actions
		keymaps = {
			["<C-h>"] = ":TmuxNavigateLeft<CR>",
			["<C-j>"] = ":TmuxNavigateDown<CR>",
			["<C-k>"] = ":TmuxNavigateUp<CR>",
			["<C-l>"] = ":TmuxNavigateRight<CR>",
			["gx"] = ":!nautilus .<CR>",
		},
		use_default_keymaps = true,
	},
}
