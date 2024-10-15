-- local keys = {}
-- local sts = require("syntax-tree-surfer")
-- local jumps = {
-- 	"variable_declaration",
-- 	"arrow_function",
-- 	"function",
-- 	"function_definition",
-- 	"if_statement",
-- 	"else_clause",
-- 	"else_statement",
-- 	"elseif_statement",
-- 	"switch_statement",
-- 	"for_statement",
-- 	"while_statement",
-- }
--
-- -- Jump The Master Node relative to the cursor with it's siblings
-- table.insert(keys, { "<A-i>", function() sts.filtered_jump(jumps, false) end, })
-- table.insert(keys, { "<A-u>", function() sts.filtered_jump(jumps, true) end, })
--
-- -- Swap The Master Node relative to the cursor with it's siblings
-- table.insert(keys, { "<A-k>", function() vim.cmd [[STSSwapUpNormal]] end, })
-- table.insert(keys, { "<A-j>", function() vim.cmd [[STSSwapDownNormal]] end, })
--
-- -- Swap Current Node at the Cursor with it's siblings
-- table.insert(keys, { "<A-h>", function() vim.cmd [[STSSwapCurrentNodePrevNormal]] end, })
-- table.insert(keys, { "<A-l>", function() vim.cmd [[STSSwapCurrentNodeNextNormal]] end, })
--
-- -- Holds a node, or swaps the held node
-- table.insert(keys, { "<A-y>", "<cmd>STSSwapOrHold<cr>", })
--
return {
	"ziontee113/syntax-tree-surfer",
	-- keys = keys,
	config = function()
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		local sts = require("syntax-tree-surfer")

		local jumps = {
			"variable_declaration",
			"arrow_function",
			"function",
			"function_definition",
			"if_statement",
			"else_clause",
			"else_statement",
			"elseif_statement",
			"switch_statement",
			"for_statement",
			"while_statement",
		}

		map("n", "<A-s-k>", function() sts.filtered_jump(jumps, false) end, opts)
		map("n", "<A-s-j>", function() sts.filtered_jump(jumps, true) end, opts)

		map("n", "<A-k>", function() vim.cmd [[STSSwapUpNormal]] end, opts)
		map("n", "<A-j>", function() vim.cmd [[STSSwapDownNormal]] end, opts)
		map("n", "<A-h>", function() vim.cmd [[STSSwapCurrentNodePrevNormal]] end, opts)
		map("n", "<A-l>", function() vim.cmd [[STSSwapCurrentNodeNextNormal]] end, opts)

		map("n", "<A-y>", "<cmd>STSSwapOrHold<cr>", opts)
	end
}
