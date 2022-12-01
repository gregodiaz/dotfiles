local harpoon = require "harpoon"

harpoon.setup {}

local opts = { noremap = true, silent = true, expr = false }

vim.keymap.set('n', '<leader>ss', require("harpoon.ui").toggle_quick_menu, opts)

vim.keymap.set('n', '<leader>sa', require("harpoon.mark").add_file, opts)

vim.keymap.set('n', '<leader>su', function() require("harpoon.ui").nav_file(1) end, opts)
vim.keymap.set('n', '<leader>si', function() require("harpoon.ui").nav_file(2) end, opts)
vim.keymap.set('n', '<leader>so', function() require("harpoon.ui").nav_file(3) end, opts)
vim.keymap.set('n', '<leader>sp', function() require("harpoon.ui").nav_file(4) end, opts)
