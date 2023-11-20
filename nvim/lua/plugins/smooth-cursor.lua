return {
	"gen740/SmoothCursor.nvim",
	config = function()
		require("smoothcursor").setup({ cursor = "◆" })

		vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#E3BE18" })

		local autocmd = vim.api.nvim_create_autocmd

		autocmd({ "ModeChanged" }, {
			callback = function()
				local current_mode = vim.fn.mode()
				if current_mode == "n" then
					vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#E3BE18" })
					vim.fn.sign_define("smoothcursor", { text = "◆" })
				elseif current_mode == "v" then
					vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#BF616A" })
					vim.fn.sign_define("smoothcursor", { text = "↔" })
				elseif current_mode == "V" then
					vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#BF616A" })
					vim.fn.sign_define("smoothcursor", { text = "↕" })
				elseif current_mode == "\22" then
					vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#BF616A" })
					vim.fn.sign_define("smoothcursor", { text = "" })
				elseif current_mode == "i" then
					vim.api.nvim_set_hl(0, "SmoothCursor", { fg = "#668AAB" })
					vim.fn.sign_define("smoothcursor", { text = "◇" })
				end
			end,
		})
	end,
}