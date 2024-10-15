return {
	"HiPhish/nvim-ts-rainbow2",
	enabled = false,
	config = function()
		require('nvim-treesitter.configs').setup {
			-- auto_install = 'maintained',
			rainbow = {
				diagnostics = false,
				enable = true,
				disable = {},
				query = 'rainbow-parens',
				-- strategy = require('ts-rainbow').strategy.global,
				hlgroups = {
					'TSRainbowYellow',
					'TSRainbowViolet',
					'TSRainbowOrange',
					'TSRainbowBlue',
					'TSRainbowCyan',
					'TSRainbowGreen',
					'TSRainbowRed'
				},
			},
		}
	end,
}
