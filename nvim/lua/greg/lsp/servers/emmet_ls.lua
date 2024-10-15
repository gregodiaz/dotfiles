local lsp_attach = require "greg.lsp.attach"
local lsp_flags = require "greg.lsp.flags"

return function(ops)
	local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
	return vim.tbl_extend("force", {
		on_attach = lsp_attach,
		flags = lsp_flags,
		capabilities = capabilities,
		filetypes = {
			"html",
			"typescriptreact",
			"javascriptreact",
			"css",
			"sass",
			"scss",
			"less",
			"blade",
			"astro",
			"vue",
		},
	}, ops)
end
