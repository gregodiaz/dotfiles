return {
	"rcarriga/nvim-notify",
	config = function()
		local notify = require "notify"
		vim.notify = notify.notify

		notify.setup {
			render = "wrapped-compact",
			max_width = 69,
		}
	end,
}
