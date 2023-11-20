local telescope_mapper = require "greg.telescope.mappings"

local filetype_attach = setmetatable({}, {
	__index = function()
		return function()
		end
	end,
})

return function(client, bufnr)
	local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.implementation, bufopts)

	vim.keymap.set("n", "<tab>", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader><leader>rl", ":LspRestart<cr>", { noremap = true })
	vim.keymap.set({ "n", "v" }, "<leader>vca", vim.lsp.buf.code_action, {})

	telescope_mapper("gt", "lsp_references", nil, true)
	telescope_mapper("<leader>pd", "lsp_document_symbols", nil, true)

	vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

	-- Attach any filetype specific options to the client
	filetype_attach[filetype](client, bufnr)
end
