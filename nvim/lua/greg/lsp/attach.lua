local telescope_mapper = require "greg.telescope.mappings"

return function(client, bufnr)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "LSP go to definition" })
	vim.keymap.set("n", "gr", vim.lsp.buf.implementation, { buffer = 0, desc = "LSP go to implementation" })

	vim.keymap.set("n", "<tab>", vim.lsp.buf.hover, { buffer = 0, desc = "LSP Help information of symbol under the cursor" })
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = 0, desc = "LSP Rename symbol under cursor" })
	vim.keymap.set("n", "<leader><leader>rl", ":LspRestart<cr>", { noremap = true, desc = "LSP Restart Server" })
	vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, { buffer = 0, desc = "LSP Code actions" })
	-- vim.keymap.set("i", "<c-h>", vim.lsp.buf.signature_help, { buffer = 0, desc = "LSP Signature help" })

	vim.keymap.set("n", "<leader>f", function()
		return vim.lsp.buf.format { async = true }
	end, { buffer = 0, desc = "LSP format file" })

	telescope_mapper("gt", "lsp_references", { buffer = true, desc = "LSP References of symbol on cursor" })
	telescope_mapper("<leader>pd", "lsp_document_symbols", { buffer = true, desc = "LSP document symbols" })

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- if client.server_capabilities.inlayHintProvider then
	-- 	vim.lsp.inlay_hint(bufnr, true)
	-- end
end
