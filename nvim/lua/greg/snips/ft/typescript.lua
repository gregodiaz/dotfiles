local ls = require "luasnip"

local snippet_from_nodes = ls.sn
local c = ls.choice_node
local t = ls.text_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

local types = function(position, default)
	local possibles = { "", "number", "string", "boolean", "null", "undefined", "any" }
	local options = {}
	default = default or "any"

	for _, value in pairs(possibles) do
		if value == default then
			table.insert(options, 1, t(value))
		else
			table.insert(options, t(value))
		end
	end

	return c(position, options)
end

local current_buf_line_number = function() return string.format("%d", vim.fn.getpos(".")[2]) end
local file_name = function() return vim.fn.expand "%:t:r" end
local inner_braces = function() return fmt([[{{ {} }}]], { i(1, "") }) end
local inner_square_brackets = function() return fmt([[ [{}] ]], { i(1, "") }) end
local inner_parentheses = function() return fmt([[ ({}) ]], { i(1, "") }) end

local inner_object = function()
	return fmt(
		[[{{ {}: {} }}]],
		{
			i(1, "prop"),
			c(2, {
				t "",
				inner_braces(),
				inner_square_brackets(),
			}),
		}
	)
end

local key_value = function()
	return fmt(
		[[{}: {}]],
		{
			i(1, "key"),
			types(2, ""),
		}
	)
end

local toggle_export = function(number) return c(number, { t "", t "export " }) end
local toggle_async = function(number) return c(number, { t "", t "async " }) end
local toggle_return = function(number) return c(number, { t "", t "return " }) end

local arrow_function = function()
	return fmt(
		[[{}({}) => {}]],
		{
			toggle_async(3),
			c(1, {
				t "",
				key_value(),
				inner_object(),
			}),
			c(2, {
				t "",
				inner_braces(),
				fmt(
					[[{{
	{}
	return{}
}}]],
					{ i(2, ""), i(1, "") }
				),
			}),
		}
	)
end

local prop_component = function()
	return fmt(
		[[{}={{{}}}]],
		{
			i(1, "prop"),
			i(2, ""),
		}
	)
end

local var_name = function(args)
	return snippet_from_nodes(nil, {
		i(1, args[1][1]:gsub("^%u", string.lower) or ""),
	})
end

local capitalize = function(args)
	return snippet_from_nodes(nil, {
		i(1, args[1][1]:gsub("^%l", string.upper) or ""),
	})
end

local M = {}

M.k = key_value()
M.o = inner_object()
M.a = arrow_function()
M.r = fmt([[return {}]], { i(1, "") })

M.pc = prop_component()
M.c = fmt(
	[[{}const {} = {}]],
	{
		toggle_export(3),
		c(1, {
			i(1, "name"),
			inner_braces(),
		}),
		c(2, {
			i(1, "'value'"),
			inner_braces(),
			inner_square_brackets(),
			arrow_function(),
		}),
	}
)

M.cn = fmt([[class{}={}]], {
	c(2, {
		t "Name",
		t ""
	}),
	c(1, {
		fmt([[{{{}.{}}}]], { i(1, "styles"), i(2, "container") }),
		fmt([['{}']], { i(1, "") }),
	}),
})

M[".c"] = fmt(
	[[.{{{}.{}}}]],
	{
		i(2, "styles"),
		i(1, ""),
	}
)

M.t = fmt(
	[[{}type {} = {}]],
	{
		toggle_export(3),
		i(1, "Type"),
		c(2, {
			t "",
			fmt(
				[[{{
	{}: {}
}}]],
				{
					i(1, "prop"),
					types(2),
				}
			),
		}),
	}
)

M.f = fmt(
	[[{}{}function {}() {{
	{}
}}]],
	{
		toggle_export(3),
		toggle_async(4),
		i(1, "name"),
		c(2, {
			fmt(
				[[
{}
	return {}
]],
				{
					i(2, ""),
					i(1, ""),
				}
			),
			i(1, ""),
		}),
	}
)

M.i = fmt(
	[[import {} from '{}{}']],
	{
		c(1, {
			i(1, ""),
			inner_braces(),
		}),
		i(2, "./"),
		d(3, var_name, { 1 }),
	}
)

M.cl = fmt(
	[[console.log({})]],
	{
		c(1, {
			fmt(
				[['{}: ', {}]],
				{
					d(2, var_name, { 1 }),
					i(1, "test"),
				}
			),
			fmt(
				[['{}:{} => {}: ', {}]],
				{
					f(file_name),
					f(current_buf_line_number),
					d(2, var_name, { 1 }),
					i(1, "test"),
				}
			),
			i(1, ""),
		}),
	}
)

M.ce = fmt(
	[[console.error({})]],
	{
		i(1, ""),
	}
)

M.us = fmt(
	[[const [{}, set{}] = useState{}{}({})]],
	{ i(1, ""), d(5, capitalize, { 1 }), i(4, ""), c(3, { t "", fmt([[<{}>]], { i(1, "") }) }), i(2, "") }
)

M.ur = fmt(
	[[const {} = useRef{}{}({})]],
	{ i(1, ""), i(4, ""), c(3, { t "", fmt([[<{}>]], { i(1, "") }) }), i(2, "") }
)

M.uc = fmt(
	[[const {} = useCallback{}({}, [{}])]],
	{ i(1, ""), i(4, ""), c(3, { arrow_function() }), i(2, "") }
)

M.um = fmt(
-- [[const {} = useRef{}{}({})]],
	[[const {} = useMemo{}(() => {}, [{}])]],
	{ i(1, ""), i(4, ""), c(3, { t "", inner_braces(), inner_square_brackets(), inner_parentheses() }), i(2, "") }
)

M.ue = fmt(
	[[useEffect{}(() => {{
	{}
}}, [{}])]],
	{ i(3, ""), i(2, ""), i(1, "") }
)

M.uel = fmt(
	[[useEffect{}(() => console.log('{}{}: ', {}), [{}])]],
	{
		i(5, ""),
		c(4, {
			t "",
			fmt([[{}:{} => ]], {
				f(file_name),
				f(current_buf_line_number),
			}),
		}),
		d(3, var_name, { 1 }),
		d(2, var_name, { 1 }),
		i(1, "test"),
	}
)

M.uh = fmt(
	[[const {} = use{}({})]],
	{ c(3, { t "", inner_braces(), inner_square_brackets() }), i(1, ""), i(2, "") }
)

M.C = fmt(
	[[<{} {}/>]],
	{ i(1, ""), i(2, "") }
)

M.nfc = fmt(
	[[
{}
export default function {}({}) {{
	{}

	return ({})
}}
	]],
	{
		c(1, {
			t "",
			fmt(
				[[
type {}Props = {{
	{}: {}
}}

			]],
				{
					f(file_name),
					i(1, "prop"),
					types(2, "string"),
				}
			),
		}),
		f(file_name),
		c(2, {
			-- t "",
			i(1, ""),
			fmt([[{}: {}Props]], { c(1, { i(1, ""), inner_braces() }), f(file_name) }),
		}),
		i(4, ""),
		c(3, {
			i(1, ""),
			fmt([[ <div>{{{}}}</div> ]], { i(1, "") }),
			fmt([[ <>{{{}}}</> ]], { i(1, "") }),
		}),
	}
)

return M
