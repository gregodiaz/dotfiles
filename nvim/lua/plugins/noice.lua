return {
	"folke/noice.nvim",
	-- enabled = false,
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			presets = {
				command_palette = true,
				long_message_to_split = true,
				inc_rename = false,
				-- lsp_doc_border = false,
			},
			cmdline = {
				format = {
					cmdline = { pattern = "^:", icon = "", lang = "vim" },
					-- cmdline = { pattern = "^:", icon = "", lang = "regex" },
				}

			},
			views = {
				cmdline_popup = {
					position = {
						col = "50%",
						row = "50%",
					},
				},
			},
		})

		vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = 'Dismiss Noice Message' })
	end
}
