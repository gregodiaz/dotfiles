local config = function()
	if vim.g.snippets ~= "luasnip" then
		return
	end

	local ls = require "luasnip"
	local types = require "luasnip.util.types"

	ls.config.set_config {
		-- This tells LuaSnip to remember to keep around the last snippet.
		-- You can jump back into even if you move outside of the selection
		history = true,

		-- This one is cool cause if you have dynamic snippets, it updatesas you type!
		updateevents = "TextChanged,TextChangedI",

		-- Autosnippets:
		enable_autosnippets = true,

		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { "<- Choice", "Error" } },
				},
			},
		},
	}

	-- create snippet
	-- s(context, nodes, condition, ...)
	local snippet = ls.s

	-- TODO: Write about this.
	--  Useful for dynamic nodes and choice nodes
	-- local snippet_from_nodes = ls.sn

	-- This is the simplest node.
	--  Creates a new text node. Places cursor after node by default.
	--  t { "this will be inserted" }
	--
	--  Multiple lines are by passing a table of strings.
	--  t { "line 1", "line 2" }
	local t = ls.text_node

	-- Insert Node
	--  Creates a location for the cursor to jump to.
	--      Possible options to jump to are 1 - N
	--      If you use 0, that's the final place to jump to.
	--
	--  To create placeholder text, pass it as the second argument
	--      i(2, "this is placeholder text")
	local i = ls.insert_node

	-- Function Node
	--  Takes a function that returns text
	-- local f = ls.function_node

	-- This a choice snippet. You can move through with <c-l> (in my config)
	--   c(1, { t {"hello"}, t {"world"}, }),
	--
	-- The first argument is the jump position
	-- The second argument is a table of possible nodes.
	--  Note, one thing that's nice is you don't have to include
	--  the jump position for nodes that normally require one (can be nil)
	-- local c = ls.choice_node

	-- local d = ls.dynamic_node

	-- TODO: Document what I've learned about lambda
	-- local l = require("luasnip.extras").lambda

	-- local events = require("luasnip.util.events")

	local shortcut = function(val)
		if type(val) == "string" then
			return { t { val }, i(0) }
		end

		if type(val) == "table" then
			for k, v in ipairs(val) do
				if type(v) == "string" then
					val[k] = t { v }
				end
			end
		end

		return val
	end

	local make = function(tbl)
		local result = {}
		for k, v in pairs(tbl) do
			table.insert(result, (snippet({ trig = k, desc = v.desc }, shortcut(v))))
		end

		return result
	end

	ls.cleanup()
	for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/greg/snips/ft/*.lua", true)) do
		local ft = vim.fn.fnamemodify(ft_path, ":t:r")
		if ft == "typescript" then
			ls.add_snippets("typescript", make(loadfile(ft_path)()))
			ls.add_snippets("typescriptreact", make(loadfile(ft_path)()))
			ls.add_snippets("javascript", make(loadfile(ft_path)()))
			ls.add_snippets("javascriptreact", make(loadfile(ft_path)()))
			ls.add_snippets("astro", make(loadfile(ft_path)()))
		else
			ls.add_snippets(ft, make(loadfile(ft_path)()))
		end
	end

	-- <c-CR> expand key.
	-- vim.keymap.set({ "i", "s" }, "<c-CR>", function() ls.expand_or_jump() end, { silent = true })
	vim.keymap.set({ "i", "s" }, "<c-CR>", function() ls.expand() end, { silent = true })

	-- <c-l> jump forwards key.
	vim.keymap.set({ "i", "s" }, "<c-l>", function() ls.jump(1) end, { silent = true })
	-- <c-j> jump backwards key.
	vim.keymap.set({ "i", "s" }, "<c-h>", function() ls.jump(-1) end, { silent = true })

	-- <c-m> selecting forward within a list of options.
	vim.keymap.set({ "i", "s" }, "<c-j>", function()
		if ls.choice_active() then ls.change_choice(1) end
	end)

	-- <c-u> selecting backwards within a list of options.
	vim.keymap.set({ "i", "s" }, "<c-k>", function()
		if ls.choice_active() then ls.change_choice(-1) end
	end)
end

return {
	"L3MON4D3/LuaSnip",
	version = "v2.*",
	event = "VeryLazy",
	config = function()
		config()
		vim.keymap.set("n", "<leader><leader>s", config, { desc = "Reload snippets" })
	end,
}
