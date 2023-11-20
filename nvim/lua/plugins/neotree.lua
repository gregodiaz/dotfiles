return {
	"nvim-neo-tree/neo-tree.nvim",
	-- enabled = false,
	keys = { { "<C-n>", vim.cmd.Neotree, mode = "n" } },
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "kyazdani42/nvim-web-devicons" },
		{ "MunifTanjim/nui.nvim" },
	},
	opts = {
		default_component_configs = {
			container = {
				enable_character_fade = true
			},
			indent = {
				indent_size = 2,
				padding = 1, -- extra padding on left hand side
				-- indent guides
				with_markers = true,
				indent_marker = "│",
				last_indent_marker = "└",
				highlight = "NeoTreeIndentMarker",
				-- expander config, needed for nesting files
				with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
			},
			icon = {
				folder_closed = " ",
				folder_open = " ",
				folder_empty = " ",
				-- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
				-- then these will never be used.
				default = " ", --
				highlight = "NeoTreeFileIcon"
			},
			modified = {
				symbol = "",
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false,
				use_git_status_colors = true,
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					-- Change type
					added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
					modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
					deleted   = "✖", -- this can only be used in the git_status source
					renamed   = "", -- this can only be used in the git_status source
					-- Status type
					untracked = "",
					ignored   = "",
					unstaged  = "",
					staged    = "",
					conflict  = "",
				}
			},
		},
		window = {
			position = 'right',
			width = 30,
			mappings = {
				["<cr>"] = {
					"open",
					-- "close_window"
				}
			},
		},
		filesystem = {
			filtered_items = {
				visible = true, -- when true, they will just be displayed differently than normal items
				hide_dotfiles = false,
				hide_gitignored = true,
			},
		}
	}
}
