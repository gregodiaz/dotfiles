local utils = require("greg.utils")
local map = vim.keymap.set

-----------------ThePrimeagen's keymaps ----------------
map("n", "<leader>pv", vim.cmd.Ex)

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("n", "J", "mzJ`z")
map("n", "J", "<C-d>zz")
map("n", "K", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "<leader>p", '"_dP')

map("n", "<leader>Q", "<nop>")
map("n", "<C-g>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

map("n", "<C-m>", "<cmd>cnext<CR>zz")
map("n", "<C-,>", "<cmd>cprev<CR>zz")
map("n", "<C-.>", "<cmd>lnext<CR>zz")
map("n", "<C-/>", "<cmd>lprev<CR>zz")

map("n", "<leader>re", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>")
map("n", "<leader><leader>re", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>")
map("n", "<leader>ch", "<cmd>!chmod +x %<CR>")

-- symbols to add undo points
local symbols = { ",", ".", "!", "?", "$", ">", "<" }
for _, symbol in pairs(symbols) do
	map("i", symbol, symbol .. "<C-g>u")
end

----------------- my keymaps ----------------
-- basics
map("n", "<leader>q", ":q")
map("n", "<leader>x", ":x")
map("n", "<leader>w", ":w<CR>")
map("n", "<leader>W", ":wa<CR>")
map("n", "<leader>n", ":noh<CR>")
map("n", "U", "<C-r>")

-- utils
map("n", "<leader><leader>l", utils.save_and_exec)
map("n", "<leader><leader>w", utils.toggle_wrap)

-- diagnostic navigation
map("n", "<C-d>", vim.diagnostic.goto_prev, {})
map("n", "<C-f>", vim.diagnostic.goto_next, {})
map("n", "<C-s>", vim.diagnostic.open_float, {})

-- buffer navigation
map("n", "<C-r>", ":bn<CR>", { noremap = true })
map("n", "<C-e>", ":bp<CR>")
map("n", "<C-w>", ":b#<CR>")
map("n", "<C-t>", ":bd<CR>")

-- window navigation
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")

-- sorting
map('v', '<leader>o', ":\'<,\'>sort<CR>")

-- quick split
map("n", "<leader>sh", ":sp<CR>")
map("n", "<leader>sv", ":vsp<CR>")

-- tabulation
map("v", "<", "<gv")
map("v", ">", ">gv")

-- terminal
map("n", "<leader>tv", ":vsp | term<CR>i")
map("n", "<leader>th", ":sp | term<CR>i")
map("n", "<leader>tt", ":term<CR>i")

-- Nextjs
function CheckUseClient()
	local first_line = vim.fn.getline(1)
	return string.find(first_line, "use client")
end

function AddUseClient()
	local has_use_client = CheckUseClient()
	if not has_use_client then
		vim.api.nvim_buf_set_lines(0, 0, 0, false, { "'use client'", "" })
	end
end

function RemoveUseClient()
	local has_use_client = CheckUseClient()
	local second_line_empty = vim.fn.empty(vim.fn.getline(2)) == 1

	if has_use_client then
		local lines_to_remove = second_line_empty and 2 or 1
		vim.api.nvim_buf_set_lines(0, 0, lines_to_remove, false, {})
	end
end

-- Utiliza tu función de mapeo
map('n', '<leader>uc', [[:lua AddUseClient()<CR>]])
map('n', '<leader>us', [[:lua RemoveUseClient()<CR>]])
