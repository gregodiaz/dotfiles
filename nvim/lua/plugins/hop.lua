local keys = {}

local function jump_back_to_original_buffer(original_buffer) --{{{
	local current_buffer = vim.api.nvim_get_current_buf()

	if current_buffer ~= original_buffer then
		vim.cmd([[normal! ]]) -- jump back to the original buffer
	else
		vim.cmd([[normal! ]]) -- jump back to the original line
	end
end

-- hiper jumps
table.insert(keys, { "<leader>ss", function() vim.cmd.HopPattern() end, desc = "Hop Pattern" })
table.insert(keys, { "<leader>sd", function() vim.cmd.HopWord() end, desc = "Hop Word" })
table.insert(keys, { "<leader>sf", function() vim.cmd.HopChar2() end, desc = "Hop Char" })

-- hiper yank
table.insert(keys, { "<leader>yl", function()
	local original_buffer = vim.api.nvim_get_current_buf()

	vim.cmd.HopLineStartMW() --> jump to line not empty
	vim.schedule(function()
		vim.cmd([[normal! yy]]) --> yank the line
		jump_back_to_original_buffer(original_buffer)
	end)
end, })

table.insert(keys, { "<leader>yx", function()
	local original_buffer = vim.api.nvim_get_current_buf()

	vim.cmd.HopLineStartMW() --> jump to line not empty
	vim.schedule(function()
		vim.cmd([[normal! dd]]) --> delete the line
		jump_back_to_original_buffer(original_buffer)
	end)
end, })

-- hiper paste
table.insert(keys, { "<leader>vp", function()
	vim.cmd.HopLineStart()
	vim.schedule(function()
		vim.cmd([[normal! p]]) --> paste
	end)
end, })
table.insert(keys, { "<leader><leader>vp", function()
	vim.cmd.HopLineStart()
	vim.schedule(function()
		vim.cmd([[normal! o]]) --> make new line below target
		vim.cmd([[normal! p]]) --> paste
	end)
end, })

table.insert(keys, { "<leader>vP", function()
	vim.cmd.HopLineStart()
	vim.schedule(function()
		vim.cmd([[normal! P]]) --> paste
	end)
end, })
table.insert(keys, { "<leader><leader>vP", function()
	vim.cmd.HopLineStart()
	vim.schedule(function()
		vim.cmd([[normal! O]]) --> make another new line below target
		vim.cmd([[normal! P]]) --> paste
	end)
end, })

-- hiper insert line
table.insert(keys, { "<leader>vo", function()
	vim.cmd.HopLineStart()
	vim.schedule(function()
		vim.cmd([[normal! o]])
		vim.cmd([[startinsert]])
	end)
end, })
table.insert(keys, { "<leader><leader>o", function()
	vim.cmd.HopLineStart()
	vim.schedule(function()
		vim.cmd([[normal! o]])
		vim.cmd([[normal! o]])
		vim.cmd([[startinsert]])
	end)
end, })


-- table.insert(keys, { "<leader>O", function()
-- 	vim.cmd.HopLineStart()
-- 	vim.schedule(function()
-- 		vim.cmd([[normal! O]])
-- 		vim.cmd([[startinsert]])
-- 	end)
-- end, })
table.insert(keys, { "<leader><leader>O", function()
	vim.cmd.HopLineStart()
	vim.schedule(function()
		vim.cmd([[normal! O]])
		vim.cmd([[normal! O]])
		vim.cmd([[startinsert]])
	end)
end, })

-- hiper nodes
table.insert(keys, { "<leader>nv", function()
	vim.cmd.HopLineStartMW()
	vim.schedule(function()
		require("tsht").nodes()
		vim.schedule(function()
			vim.cmd([[normal! V]])
		end)
	end)
end, })

table.insert(keys, { "<leader>ny", function()
	vim.cmd.HopLineStartMW()
	vim.schedule(function()
		require("tsht").nodes()
		vim.schedule(function()
			vim.cmd([[normal! y]]) --> yank
		end)
	end)
end, })

table.insert(keys, { "<leader>nc", function()
	vim.cmd.HopLineStartMW()
	vim.schedule(function()
		require("tsht").nodes()
		vim.schedule(function()
			vim.cmd([[normal! c]])
			vim.cmd([[startinsert]])
		end)
	end)
end, })

return {
	"phaazon/hop.nvim",
	dependencies = { "mfussenegger/nvim-treehopper" },
	keys = keys,
	event = "VeryLazy",
	branch = "v2",
	config = true
}
