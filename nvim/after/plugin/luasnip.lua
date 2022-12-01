local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local types = require("luasnip.util.types")
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local m = extras.m
local l = extras.l
local rep = extras.rep
local postfix = require("luasnip.extras.postfix").postfix

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

ls.add_snippets("all", {
  s("imp", {
    t("import "), i(1, ""), t(" from \'"), c(2, { t("./"), t("../") }), i(3, ""), t("\';"),
  }),

  s("cn", {
    t("className=\'"), i(1, "container"), t("\' ")
  }),

  s("cl", {
    t("console.log("), i(1, "var"), t(")")
  }),

  s("cle", {
    t("console.log(\'"),
    f(function(args)
      return args[1][1]:gsub("^%u", string.lower)
    end, { 1 }),
    t(": \',"), i(1, "var"), t(")")
  })
})

ls.add_snippets("php", {
  -- Route
  s("ro", {
    t("Route::"),
    c(1, {
      t("get"),
      t("post"),
      t("put"),
      t("delete"),
    }),
    t("('"),
    i(2, "uri"),
    t("',"),
    c(3, {
      sn(nil, {
        t("["),
        i(1, "Controller"),
        t("::class, \'"),
        i(2, "method"),
        t("\']);"),
      }),
      sn(nil, {
        t({ 'function(){', '' }),
        i(1, ''),
        t({ '', '});' }),
      }),
    })
  }),

  -- function
  s("fu", {
    c(1, {
      t("public"),
      t("protected"),
      t("private"),
    }),
    t(" function "),
    i(2, "name"),
    t("("),
    i(3, "Type"),
    t(" $"),
    f(function(args)
      return args[1][1]:gsub("^%u", string.lower)
    end, { 3 }),
    t({ ")", "{", "    " }),
    i(0),
    t({ "", "}", "" }),
  }),

  -- __construct
  s("cc", {
    c(1, { t("public"), t("private"), t("protected") }),
    t({ " function __construct(" }),
    c(2, {
      sn(nil, {
        t("$"),
        i(1, 'var'),
        t({ ")", "{", "    " }),
        i(2, ''),
        t({ "", "}" }),
      }),
      sn(nil, {
        i(1, "Type"),
        t(" $"),
        f(function(args)
          return args[1][1]:gsub("^%u", string.lower)
        end, { 1 }),
        t({ ",", ") {", "}", "" }),
      }),
    }),
    i(3),
    t({ "){", "" }),
    i(0),
    t({ "", "}" }),
  }
  ),

  -- php docs
  s("v", {
    t({ "/**", " * " }),
    i(1, 'Description...'),
    t({ "", " *", " * @param " }),
    i(2, 'type'),
    t({ " $" }),
    i(3, 'var'),
    t({ "    ", " * @return " }),
    i(4, 'type'),
    t({ " $" }),
    i(5, 'var'),
    t({ "    ", " */" }),
  }
  ),
})



-- local newline = function(text)
--     return t({ "", text })
-- end

-- local visibility = function(position, default)
--     local possibles = { "private", "public" }
--     local options = {}

--     for _, value in pairs(possibles) do
--         if value == default then
--             table.insert(options, 1, t(value))
--         else
--             table.insert(options, t(value))
--         end
--     end

--     return c(position, options)
-- end

-- local namespace = function()
--     local dir = vim.fn.expand("%:h")
--     local autoloads = composer.query({ "autoload", "psr-4" })
--     if autoloads == nil then
--         return (dir:gsub("^%l", string.upper))
--     end

--     local globalNamespace
--     for key, value in pairs(autoloads) do
--         if string.starts(dir, value:sub(1, -2)) then
--             globalNamespace = key:sub(1, -2)
--             dir = dir:sub(#key + 1)
--             break
--         end
--     end
--     dir = dir:gsub("/", "\\")
--     if dir == "" then
--         return globalNamespace
--     end

--     return string.format("%s\\%s", globalNamespace, dir)
-- end

-- local class_name = function()
--     return vim.fn.expand("%:t:r")
-- end

-- local  = {}

-- .class = fmt(
--     [[
-- <?php
-- declare(strict_types=1);
-- namespace {};
-- class {}
-- {{
--     {}
-- }}
-- ]]   ,
--     {
--         f(namespace),
--         f(class_name),
--         i(0),
--     }
-- )

-- .pro = fmt([[{} {} ${},]], {
--     visibility(1, "private"),
--     i(2, "Type"),
--     f(function(args)
--         return args[1][1]:gsub("^%u", string.lower)
--     end, { 2 }),
-- })

-- .rpro = fmt([[{} readonly {} ${},]], {
--     visibility(1, "public"),
--     i(2, "int"),
--     i(3, ""),
-- })

-- ._c = fmt(
--     [[{} function __construct({}) {{
--     {}
-- }}]] ,
--     {
--         visibility(1, "public"),
--         i(2),
--         i(0),
--     }
-- )

-- ._p = fmt(
--     [[{} function __construct(
--     {}
-- ) {{
-- }}]] ,
--     {
--         visibility(1, "public"),
--         i(2),
--     }
-- )

-- .strict = t("declare(strict_types=1);")

-- .fn = {
--     visibility(1, "public"),
--     t(" function "),
--     i(2, "name"),
--     t("("),
--     i(3, "$arg"),
--     t(")"),
--     c(4, {
--         t(""),
--         -- snippet_from_nodes(nil, {
--         --     t(": "),
--         --     i(1, "void"),
--         -- }),
--     }),
--     newline("{"),
--     newline("\t"),
--     i(0, ""),
--     newline("}"),
-- }

-- ["then"] = fmt([[->then(function ({}) {{
--     {}
-- }})]], { i(1, ""), i(2, "") })

-- .test = fmt([[/**
--  * @test
--  */
-- public function it_{}(): void
-- {{
--     {}
-- }}
-- ]], { i(1, ""), i(0, "") })
