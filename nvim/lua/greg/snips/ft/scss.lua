local ls = require "luasnip"

local snippet_from_nodes = ls.sn
local c = ls.choice_node
local t = ls.text_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local var_name = function(args)
	return snippet_from_nodes(nil, {
		i(1, args[1][1]:gsub("^%u", string.lower) or ""),
	})
end

local M = {}

M.cn = fmt(
	[[
	[{}-start] [{}-end]
	]],
	{
		i(1, "full"),
		d(2, var_name, { 1 }),
	}
)

return M
