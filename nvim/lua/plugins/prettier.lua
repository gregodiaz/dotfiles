return {
	'MunifTanjim/prettier.nvim',
	dependencies = {
		'neovim/nvim-lspconfig',
		'jose-elias-alvarez/null-ls.nvim',
	},
	config = function()
		require("prettier").setup({
			bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
			filetypes = {
				"css",
				"graphql",
				"html",
				"javascript",
				"javascriptreact",
				"json",
				"less",
				"markdown",
				"scss",
				"typescript",
				"typescriptreact",
				"yaml",
			},
			["null-ls"] = {
				condition = function()
					return require("prettier").config_exists({
						-- if `false`, skips checking `package.json` for `"prettier"` key
						check_package_json = true,
					})
				end,
				runtime_condition = function(params)
					-- return false to skip running prettier
					return true
				end,
				timeout = 5000,
			}
		})
	end,
}
