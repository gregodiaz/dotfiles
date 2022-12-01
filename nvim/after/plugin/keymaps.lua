local opts = { noremap = true, silent = true }
local function map(mode, command, landing, options)
    options = options or opts
    vim.keymap.set(mode, command, landing, options)
end

-- Leader
map('n', '<Leader>w', ':w<CR>')
map('n', '<Leader>v', ':noh<CR>')
map('n', '<Leader>q', ':q', { silent = false })
map('n', '<Leader>x', ':x', { silent = false })
map('n', '<Leader>e', ':e ', { silent = false })
map('n', '<Leader>/', ':%s/', { silent = false })
map('n', '<Leader>.', ':s/', { silent = false })
map('n', '<Leader>gi', ':G ', { silent = false })
map('n', '<leader>ar', ':Artisan<CR>', { silent = false })
map('n', '<leader>af', ':Sail ', { silent = false })

map({ 'n', 'v' }, '<Leader>c', ':Commentary<CR>')

map('n', '<Leader><tab>', 'gd')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')
map('v', '>', '>gv')
map('v', '<', '<gv')
map('v', '<Leader>o', ":\'<,\'>sort<CR>")
map('v', '<Leader>jq', ":\'<,\'>!jq<CR>")
map('v', '<Leader><Leader>jq', ":\'<,\'>!jq -c<CR>")

-- Control
map('n', '<C-n>', ':Neotree toggle<CR>')
map('n', '<C-j>', ':TmuxNavigateLeft<CR>')
map('n', '<C-k>', ':TmuxNavigateRight<CR>')
map('n', '<C-u>', ':bp<CR>')
map('n', '<C-i>', ':bn<CR>')
map('n', '<C-y>', ':bdelete<CR>')
-- map('n', '<C-u>', ':tabprevious<CR>')
-- map('n', '<C-i>', ':tabnext<CR>')
-- map('n', '<C-y>', ':tabclose<CR>')

-- Replacement
-- Normal mode
map('n', ';;', 'A;<Esc>')
map('n', '""', '<Esc>bi"<Esc>ea"')

-- Insert mode
map('i', '(', '()<Esc>i')
map('i', '{', '{}<Esc>i')
map('i', '[', '[]<Esc>i')
map('i', '\'', '\'\'<Esc>i')
map('i', '"', '""<Esc>i')
map('i', '`', '``<Esc>i')
map('i', '<F12>', ')')
map('i', '<F11>', '()<Esc>i')
map('i', '<F9>', '$')
map('i', '<F8>', '}')
map('i', '<F7>', '{}<Esc>i')
map('i', '<F6>', '=>')
map('i', '<F5>', '->')
map('i', '<F4>', ']')
map('i', '<F3>', '[]<Esc>i')

-- Visual mode
map('v', '<F11>', 'c()<Esc>PvF(l')
map('v', '<F7>', 'c{}<Esc>PvF{l')
map('v', '<F3>', 'c[]<Esc>PvF[l')
map('v', '(', 'c()<Esc>PvF(l')
map('v', '{', 'c{}<Esc>PvF{l')
map('v', '[', 'c[]<Esc>PvF[l')
map('v', '\'', 'c\'\'<Esc>PvF\'l')
map('v', '"', 'c""<Esc>PvF"l')
map('v', '`', 'c``<Esc>PvF`l')
