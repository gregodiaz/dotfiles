return {
	'akinsho/toggleterm.nvim',
	keys = {
		{ '<leader>te', vim.cmd.ToggleTerm, mode = { 'n' } },
	},
	opts = {
		size = 20,
		hide_numbers = true,  -- hide the number column in toggleterm buffers
		shade_filetypes = {},
		autochdir = true,     -- when neovim changes it current directory the terminal will change it's own when next it's opened
		shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
		shading_factor = 2,
		start_in_insert = true,
		insert_mappings = false, -- if its true, whether or not the open mapping applies in insert mode
		persist_size = true,
		direction = 'float',
		close_on_exit = true, -- close the terminal window when the process exits
		shell = vim.o.shell, -- change the default shell
		auto_scroll = true, -- automatically scroll to the bottom on terminal output
		-- This field is only relevant if direction is set to 'float'
		float_opts = {
			-- The border key is *almost* the same as 'nvim_open_win'
			-- see :h nvim_open_win for details on borders however
			-- the 'curved' border is a custom border type
			-- not natively supported but implemented in this plugin.
			border = 'curved',
			-- like `size`, width and height can be a number or function which is passed the current terminal
			winblend = 0,
			enabled = false,
			name_formatter = function(term) --  term: Terminal
				return term.name
			end
		},
	}
}
