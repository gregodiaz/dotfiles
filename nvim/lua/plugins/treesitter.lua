return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/playground",
		"nvim-treesitter/nvim-treesitter-refactor",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	main = "nvim-treesitter.configs",
	opts = {
		-- ensure_installed = {
		-- 	"astro",
		-- 	"bash",
		-- 	"css",
		-- 	"scss",
		-- 	"dockerfile",
		-- 	"http",
		-- 	"html",
		-- 	"javascript",
		-- 	"json",
		-- 	"lua",
		-- 	"markdown",
		-- 	"php",
		-- 	"phpdoc",
		-- 	"typescript",
		-- 	"tsx",
		-- 	"vim",
		-- 	"yaml"
		-- },
		sync_install = false,
		auto_install = true,
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		indent = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				-- node_incremental = "gnr",
				-- scope_incremental = "gnc",
				-- node_decremental = "gnm",
			},
		},
		refactor = {
			highlight_definitions = { enable = true },
			smart_rename = {
				enable = false,
				keymaps = {
					smart_rename = "trr",
				},
			},
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@conditional.outer",
					["ic"] = "@conditional.inner",
					["al"] = "@loop.outer",
					["il"] = "@loop.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]m"] = "@function.outer",
					["]a"] = "@parameter.inner",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]A"] = "@parameter.inner",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[a"] = "@parameter.inner",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[A"] = "@parameter.inner",
					["[]"] = "@class.outer",
				},
			},
		},
		playground = {
			enable = true,
			disable = {},
			updatetime = 25,      -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
	}
}
