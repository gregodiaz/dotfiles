local harpoon = require "harpoon"

harpoon.setup {
    menu = {
        width = vim.api.nvim_win_get_width(0)-40,
    }
}

local opts = { noremap = true, silent = true, expr = false }

vim.keymap.set('n', '<leader>ff', require("harpoon.ui").toggle_quick_menu, opts)

vim.keymap.set('n', '<leader>fa', require("harpoon.mark").add_file, opts)

vim.keymap.set('n', '<leader>fu', function() require("harpoon.ui").nav_file(1) end, opts)
vim.keymap.set('n', '<leader>fi', function() require("harpoon.ui").nav_file(2) end, opts)
vim.keymap.set('n', '<leader>fo', function() require("harpoon.ui").nav_file(3) end, opts)
vim.keymap.set('n', '<leader>fp', function() require("harpoon.ui").nav_file(4) end, opts)
vim.keymap.set('n', '<leader>fj', function() require("harpoon.ui").nav_file(5) end, opts)
vim.keymap.set('n', '<leader>fk', function() require("harpoon.ui").nav_file(6) end, opts)
vim.keymap.set('n', '<leader>fl', function() require("harpoon.ui").nav_file(7) end, opts)
vim.keymap.set('n', '<leader>f;', function() require("harpoon.ui").nav_file(8) end, opts)
vim.keymap.set('n', '<leader>fm', function() require("harpoon.ui").nav_file(9) end, opts)
vim.keymap.set('n', '<leader>f,', function() require("harpoon.ui").nav_file(10) end, opts)
vim.keymap.set('n', '<leader>f.', function() require("harpoon.ui").nav_file(11) end, opts)
vim.keymap.set('n', '<leader>f/', function() require("harpoon.ui").nav_file(12) end, opts)
