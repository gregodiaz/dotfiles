return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>g",   ":G ",                     silent = false },
		{ "<leader>gh",  ":G stash ",               silent = false },
		{ "<leader>gk",  ":G checkout ",            silent = false },
		{ "<leader>gkm", ":G checkout main<CR>",    silent = false },
		{ "<leader>gd",  ":Gvdiffsplit<CR>",        silent = false },
		-- { "<leader>gf",  ":Git fetch --all -p<cr>", silent = false },
		-- rest in ../greg/telescope/mappings.lua { t = git, d = diff, f = fetch, b = branches, c = commits, s = status }
	},
	cmd = { "G", "Git" },
}
