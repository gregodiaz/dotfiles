return {
	"neovim/nvim-lspconfig",
	dependencies = {
		-- "jose-elias-alvarez/none-ls.nvim",
		"nvimtools/none-ls.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{
			"williamboman/mason.nvim",
			opts = {
				ui = {
					border = "rounded",
				},
			},
		},
		{
			"lvimuser/lsp-inlayhints.nvim",
			config = function()
				require("lsp-inlayhints").setup()
				vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
				vim.api.nvim_create_autocmd("LspAttach", {
					group = "LspAttach_inlayhints",
					callback = function(args)
						if not (args.data and args.data.client_id) then
							return
						end

						local bufnr = args.buf
						local client = vim.lsp.get_client_by_id(args.data.client_id)
						require("lsp-inlayhints").on_attach(client, bufnr, false)
					end,
				})
			end,
		},
		{
			"j-hui/fidget.nvim",
			tag = 'legacy',
			opts = {
				window = {
					blend = 0,
				},
				sources = {
					-- ["none-ls"] = {
					["null-ls"] = {
						ignore = true,
					},
				},
			},
		},
		"folke/neodev.nvim"
	},
	event = "VeryLazy",
	main = "greg.lsp",
	opts = {},
}
