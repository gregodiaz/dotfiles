return {
	'Wansmer/treesj',
	-- keys = { '<leader>m' },
	dependencies = { 'nvim-treesitter/nvim-treesitter' },
	config = function()
		require('treesj').setup({ use_default_keymaps = false })
		vim.api.nvim_set_keymap('n', '<leader>m', ':TSJToggle<CR>', { noremap = true, silent = true })
	end,
}
