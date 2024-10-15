local cmp = require "cmp"
local lspkind = require "lspkind"
local luasnip = require "luasnip"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local compare = require "cmp.config.compare"

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

cmp.setup {
	mapping = {
		["<c-f>"] = cmp.mapping(function(fallback)
			-- ["<c-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- elseif luasnip.choice_active() then
				-- 	luasnip.change_choice(1)
			else
				fallback()
			end
		end, { "i", "s" }),
		["<c-d>"] = cmp.mapping(function(fallback)
			-- ["<c-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<CR>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},
	},
	window = {
		completion = {
			border = "rounded",
		},
		documentation = {
			border = "rounded",
		},
	},
	sources = {
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "nvim_lua" },
		{ name = "nvim_lsp_signature_help" },
		{
			name = "buffer",
			keyword_length = 4,
			option = {
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local bufnr = vim.api.nvim_win_get_buf(win)
						if vim.api.nvim_buf_get_option(bufnr, 'buftype') ~= 'terminal' then
							-- local bufnr = vim.api.nvim_get_option_value('bufnr', { win = win })
							-- local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })
							-- if buftype ~= 'terminal' then
							bufs[bufnr] = true
						end
					end
					return vim.tbl_keys(bufs)
				end
			},
		},
	},

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	formatting = {
		fields = { "abbr", "kind" },
		expandable_indicator = true,
		format = lspkind.cmp_format {
			with_text = true,
			menu = {
				buffer = "[buf]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[api]",
				path = "[path]",
				luasnip = "[snip]",
				["vim-dadbod-completion"] = "[DB]",
			},
		},
	},

	-- sorting = {
	-- 	priority_weight = 2,
	-- 	comparators = {
	-- 		compare.kind,
	-- 		compare.sort_text,
	-- 	},
	-- },

	experimental = {
		native_menu = false,

		ghost_text = false,
	},
}

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	-- mapping = cmp.mapping.preset.insert(),
	sources = {
		{ name = "buffer" },
		{ name = "path" }, -- lo agrgue yo perro (yo greg)
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	-- mapping = cmp.mapping.preset.insert(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
	sources = cmp.config.sources({
		{ name = "vim-dadbod-completion" },
	}, {
		{ name = "buffer" },
	}),
})
