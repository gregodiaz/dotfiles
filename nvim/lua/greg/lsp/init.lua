-- LSP configuration
require "greg.lsp.mason"

-- install servers and tools
local lspconfig = require "lspconfig"
local servers = require "greg.lsp.servers"

for server, setup in pairs(servers) do
    lspconfig[server].setup(setup())
end
require("neodev").setup({})

require "greg.lsp.null-ls"
