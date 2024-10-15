return {
	'MunifTanjim/prettier.nvim',
	dependencies = {
		'neovim/nvim-lspconfig',
		-- 'jose-elias-alvarez/null-ls.nvim',
		"nvimtools/none-ls.nvim",
	},
	config = function()
		local prettier = require("prettier")

		prettier.setup({
			bin = 'prettierd',
			filetypes = {
				"typescript",
				"typescriptreact",
				"javascript",
				"javascriptreact",
				"html",
				"astro",
				"css",
				"scss",
				"json",
				"yaml",
				"markdown",
				"less",
				"graphql",
				-- ".prettierrc",
			},
			-- ["none-ls"] = {
			["null-ls"] = {
				condition = function()
					return prettier.config_exists({
						-- if `false`, skips checking `package.json` for `"prettier"` key
						check_package_json = true,
					})
				end,
				runtime_condition = function(params)
					-- return false to skip running prettier
					return true
				end,
				timeout = 5000,
			},
			cli_options = {
				arrow_parens = "always",
				bracket_spacing = true,
				bracket_same_line = true,
				embedded_language_formatting = "auto",
				end_of_line = "lf",
				html_whitespace_sensitivity = "css",
				-- jsx_bracket_same_line = false,
				jsx_single_quote = true,
				print_width = 135,
				prose_wrap = "preserve",
				quote_props = "as-needed",
				semi = false,
				single_attribute_per_line = false,
				single_quote = true,
				tab_width = 2,
				trailing_comma = "es5",
				use_tabs = true,
			},
		})
	end,
}
