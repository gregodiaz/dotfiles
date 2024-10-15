local lsp_attach = require "greg.lsp.attach"
local lsp_flags = require "greg.lsp.flags"

return function(ops)
	local config = {
		on_attach = lsp_attach,
		flags = lsp_flags,
	}
	if vim.fn.executable "vscode-css-language-server" == 1 then
		config.cmd = { "vscode-css-language-server", "--stdio" }
	end

	return vim.tbl_extend("force", config, ops)
end
