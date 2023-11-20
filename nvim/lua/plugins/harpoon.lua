-- local keys = {}
-- local binds = 9
-- local mark = require("harpoon.mark")
-- local ui = require("harpoon.ui")
--
-- table.insert(keys, { "<leader><leader>h", function() ui.toggle_quick_menu() end, desc = "Toggle harpoon", })
-- table.insert(keys, { "<leader>a", function() mark.add_file() end, desc = "Add file to harpoon", })
--
-- table.insert(keys, { "<leader>j", function() ui.nav_file(1) end, desc = "Navigate to file 1", })
-- table.insert(keys, { "<leader>k", function() ui.nav_file(2) end, desc = "Navigate to file 2", })
-- table.insert(keys, { "<leader>l", function() ui.nav_file(3) end, desc = "Navigate to file 3", })
-- table.insert(keys, { "<leader>;", function() ui.nav_file(4) end, desc = "Navigate to file 4", })
--
-- for i = 1, binds do
-- 	table.insert(keys,
-- 		{ string.format("<leader>%s", i), function() ui.nav_file(i) end, desc = string.format("Navigate to file %s", i), })
-- end

return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-lua/popup.nvim",
	},
	-- keys = keys,
	config = function()
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		local ui = require("harpoon.ui")
		local mark = require("harpoon.mark")

		map("n", "<leader><leader>h", function() ui.toggle_quick_menu() end, opts)
		map("n", "<leader>a", function() mark.add_file() end, opts)

		map("n", "<leader>j", function() ui.nav_file(1) end, opts)
		map("n", "<leader>k", function() ui.nav_file(2) end, opts)
		map("n", "<leader>l", function() ui.nav_file(3) end, opts)
		map("n", "<leader>;", function() ui.nav_file(4) end, opts)

		for i = 1, 9 do
			map("n", string.format("<leader>%s", i), function() ui.nav_file(i) end, opts)
		end
	end,
	opts = {
		global_settings = {
			enter_on_sendcmd = true,
		},
		-- projects = {
		--   ["$HOME/code/svelte/snippets"] = {
		--     term = {
		--       cmds = {
		--         "npm run dev",
		--       },
		--     },
		--   },
		-- },
	},
}
