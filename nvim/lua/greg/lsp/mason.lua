local mason = require "mason"
local mason_lspconfig = require "mason-lspconfig"
local servers = require "greg.lsp.servers"
local lspconfig = require "lspconfig"

mason.setup()

local mason_servers = {}

-- TODO: can be improve checking the setup function to see if sets the cmd
for server, _ in pairs(servers) do
	local cmd = lspconfig[server].document_config.default_config.cmd[1]
	if vim.fn.executable(cmd) == 0 then
		table.insert(mason_servers, server)
	end
end

mason_lspconfig.setup {
	ensure_installed = mason_servers,
}

-- mason.use_formatter('prettier', {
-- 	command = 'prettier',
	-- args = { '--stdin-filepath', vim.api.nvim_buf_get_name(0) },
	-- rootPatterns = { '.prettierrc', '.prettierrc.json', '.prettierrc.yaml', '.prettierrc.yml', '.prettierrc.js',
-- 		'.prettierrc.cjs', 'prettier.config.js', 'prettier.config.cjs', '.editorconfig' },
-- })

-- filter the list for the ones not globally installed
require("mason-tool-installer").setup {
	ensure_installed = require "greg.lsp.tools",
}
