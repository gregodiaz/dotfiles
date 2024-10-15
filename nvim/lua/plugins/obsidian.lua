return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	keys = { {"<leader>O", "<cmd>ObsidianNew<cr>"} },
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		workspaces = {
			{
				path = "~/vaults",
			},
			-- {
			-- 	name = "personal",
			-- 	path = "~/vaults/personal",
			-- },
			-- {
			-- 	name = "work",
			-- 	path = "~/vaults/work",
			-- },
		},
	},
}
