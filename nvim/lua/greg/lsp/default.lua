return {
	mason = {
		enable = true,
		-- auto_install = false,
		auto_install = true,
	},
	servers = {
		emmet_ls = { enable = true },
		html = { enable = true },
		jsonls = { enable = true },
		lua_ls = { enable = true, neodev = true },
		-- nil_ls = { enable = true },
		tailwindcss = {
			enable = true,
			filetypes = { "blade", "html", "svelte", "javascript", "javascriptreact", "typescript", "typescriptreact" }
		},
		-- tsserver = { enable = true },
		-- ts_standard = { enable = true },
		vtsls = { enable = true },
		cssls = { enable = true },
		cssmodules_ls = { enable = true },
		astro = { enable = true },
	},
	default_options = function(options)
		return vim.tbl_deep_extend("force", {
			on_attach = require "greg.lsp.attach",
			flags = require "greg.lsp.flags",
		}, options)
	end,
}
