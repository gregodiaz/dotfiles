return {
	"adalessa/laravel.nvim",
	-- enabled = false,
	dependencies = {
		"rcarriga/nvim-notify",
		"nvim-telescope/telescope.nvim",
	},
	cmd = { "Sail", "Artisan", "Composer", "Npm", "Laravel" },
	keys = {
		{ "<leader>aa", ":Laravel artisan<cr>" },
		{ "<leader>ar", ":Laravel routes<cr>" },
	},
	config = function()
		vim.g.laravel_log_level = "debug"
		require("laravel").setup()
		require("telescope").load_extension "laravel"
	end,
}
