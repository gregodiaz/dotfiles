-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

-- local luasnip = require("luasnip")
-- local cmp = require("cmp")

-- cmp.setup({

--     -- ... Your other configuration ...

--     mapping = {

--         -- ... Your other mappings ...

--         ["<Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_next_item()
--             elseif luasnip.expand_or_jumpable() then
--                 luasnip.expand_or_jump()
--             elseif has_words_before() then
--                 cmp.complete()
--             else
--                 fallback()
--             end
--         end, { "i", "s" }),

--         ["<S-Tab>"] = cmp.mapping(function(fallback)
--             if cmp.visible() then
--                 cmp.select_prev_item()
--             elseif luasnip.jumpable(-1) then
--                 luasnip.jump(-1)
--             else
--                 fallback()
--             end
--         end, { "i", "s" }),

--         -- ... Your other mappings ...
--     },
--     -- ... Your other configuration ...
-- })


-- after/plugins/luasnip.lua
if vim.g.snippets ~= "luasnip" then
	return
end

local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config({
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
})

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
		return { t({ val }), i(0) }
	end

	if type(val) == "table" then
		for k, v in ipairs(val) do
			if type(v) == "string" then
				val[k] = t({ v })
			end
		end
	end

	return val
end

-- local make = function(tbl)
-- 	local result = {}
-- 	for k, v in pairs(tbl) do
-- 		table.insert(result, (snippet({ trig = k, desc = v.desc }, shortcut(v))))
-- 	end

-- 	return result
-- end

-- ls.cleanup()
-- for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/alpha/snips/ft/*.lua", true)) do
-- 	local ft = vim.fn.fnamemodify(ft_path, ":t:r")
-- 	ls.add_snippets(ft, make(loadfile(ft_path)()))
-- end

-- <c-k> is my expansion key
-- this will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

-- <c-j> is my jump backwards key.
-- this always moves to the previous item within the snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

-- <c-l> is selecting within a list of options.
-- This is useful for choice nodes (introduced in the forthcoming episode 2)
vim.keymap.set("i", "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

-- lua/alpha/snips/ft/php.lua
local ls = require("luasnip")
local composer = require("composer")

local snippet_from_nodes = ls.sn
local c = ls.choice_node
local t = ls.text_node
-- local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

function string.starts(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end

local newline = function(text)
	return t({ "", text })
end

local visibility = function(position, default)
	local possibles = { "private", "public" }
	local options = {}

	for _, value in pairs(possibles) do
		if value == default then
			table.insert(options, 1, t(value))
		else
			table.insert(options, t(value))
		end
	end

	return c(position, options)
end

local namespace = function()
	local dir = vim.fn.expand("%:h")
	local autoloads = composer.query({ "autoload", "psr-4" })
	if autoloads == nil then
		return (dir:gsub("^%l", string.upper))
	end

	local globalNamespace
	for key, value in pairs(autoloads) do
		if string.starts(dir, value:sub(1, -2)) then
			globalNamespace = key:sub(1, -2)
			dir = dir:sub(#key + 1)
			break
		end
	end
	dir = dir:gsub("/", "\\")
    if dir == "" then
        return globalNamespace
    end

	return string.format("%s\\%s", globalNamespace, dir)
end

local class_name = function()
	return vim.fn.expand("%:t:r")
end

local M = {}

M.v = fmt(
	[[
/**
 * @var {}
 */
{} ${};
]],
	{
		i(1, "type"),
		visibility(2, "private"),
		i(3, "var"),
	}
)
M.class = fmt(
	[[
<?php
declare(strict_types=1);
namespace {};
class {}
{{
    {}
}}
]],
	{
		f(namespace),
		f(class_name),
		i(0),
	}
)

M.pro = fmt([[{} {} ${},]], {
	visibility(1, "private"),
	i(2, "Type"),
	f(function(args)
		return args[1][1]:gsub("^%u", string.lower)
	end, { 2 }),
})

M.rpro = fmt([[{} readonly {} ${},]], {
	visibility(1, "public"),
	i(2, "int"),
    i(3, ""),
})

M._c = fmt(
	[[{} function __construct({}) {{
    {}
}}]],
	{
		visibility(1, "public"),
		i(2),
		i(0),
	}
)

M._p = fmt(
	[[{} function __construct(
    {}
) {{
}}]],
	{
		visibility(1, "public"),
		i(2),
	}
)

M.strict = t("declare(strict_types=1);")

M.fn = {
	visibility(1, "public"),
	t(" function "),
	i(2, "name"),
	t("("),
	i(3, "$arg"),
	t(")"),
	c(4, {
		t(""),
		snippet_from_nodes(nil, {
			t(": "),
			i(1, "void"),
		}),
	}),
	newline("{"),
	newline("\t"),
	i(0, ""),
	newline("}"),
}

M["then"] = fmt([[->then(function ({}) {{
    {}
}})]], {i(1, ""), i(2, "")})

M.test = fmt([[/**
 * @test
 */
public function it_{}(): void
{{
    {}
}}
]], {i(1, ""), i(0, "")})


return M
