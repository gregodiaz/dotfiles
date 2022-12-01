require("toggleterm").setup {
    size = 20,
    -- open_mapping = [[<leader>tt]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
    shade_terminals = true, -- NOTE: this option takes priority over highlights specified so if you specify Normal highlights you should set this to false
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
        -- The border key is *almost* the same as 'nvim_open_win'
        -- see :h nvim_open_win for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'curved',
        -- like `size`, width and height can be a number or function which is passed the current terminal
        winblend = 0,
        enabled = false,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end
    },
}

vim.keymap.set('n', '<Leader>te', ':ToggleTerm<CR>', { noremap = true, silent = true })

-- function _G.set_terminal_keymaps()
--     local opts = { buffer = 0 }
--     vim.keymap.set('t', '<esc>', [[<Cmd>wincmd exit<CR>]], opts)
--     vim.keymap.set('t', '<esc><esc>', 'exit<CR>', opts)
--     vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
--     vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
--     vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
--     vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
--     vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
-- end
