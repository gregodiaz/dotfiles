return {
	"tpope/vim-fugitive",
	keys = {
		{ "<leader>git", ":Git " },
		{ "<leader>gid", ":Gvdiffsplit<CR>" },
		{ "<leader>gif", ":Git fetch --all -p<cr>" },
		-- rest in ../greg/telescope/mappings.lua { t = git, d = diff, f = fetch, b = branches, c = commits, s = status }
	},
	cmd = { "G", "Git" },
}
