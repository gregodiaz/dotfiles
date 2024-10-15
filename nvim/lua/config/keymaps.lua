local utils = require("greg.utils")
local map = vim.keymap.set

-----------------ThePrimeagen's keymaps ----------------
map("n", "<leader>pv", vim.cmd.Ex)

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- map("n", "J", "mzJ`z")
map("n", "J", "<C-d>zz")
map("n", "K", "<C-u>zz")
map("n", "J", "5j")
map("n", "K", "5k")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("x", "<leader>p", '"_dP')

map("n", "<leader>Q", "<nop>")
map("n", "<C-g>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- map("n", "<C-m>", "<cmd>cnext<CR>zz")
-- map("n", "<C-,>", "<cmd>cprev<CR>zz")
-- map("n", "<C-.>", "<cmd>lnext<CR>zz")
-- map("n", "<C-/>", "<cmd>lprev<CR>zz")

map("n", "<leader>re", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>")
map("n", "<leader><leader>re", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>")
map("n", "<leader><leader>ch", "<cmd>!chmod +x %<CR>")

-- symbols to add undo points
local symbols = { ",", ".", "!", "?", "$", ">", "<", "-" }
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
map("n", "U", "<C-r>", { noremap = true })

-- utils
map("n", "<leader><leader>l", utils.save_and_exec)
-- map("n", "<leader><leader>w", utils.toggle_wrap)
map("n", "<leader>o", ":normal yyPgccj<CR>")
map("n", "<leader><leader>n", ":g/^[\t]*<C-r><C-w>/normal <Left><Left><Left><Left><Left><Left><Left><Left>",
	{ silent = false })
map("n", "<leader>c", ":normal gcc<CR>")
map("v", "<leader>c", ":\'<,\'>normal gcc<CR>")
map("n", "<leader>ls", ":Lazy sync<CR>")
map("n", "<leader><leader>c", "o{/*<Esc>o*/}<Esc>")


-- diagnostic navigation
map("n", "<C-d>", vim.diagnostic.goto_prev, {})
map("n", "<C-f>", vim.diagnostic.goto_next, {})
map("n", "<C-s>", vim.diagnostic.open_float, {})

-- buffer navigation
map("n", "<C-n>", ":bn<CR>", { noremap = true })
map("n", "<C-p>", ":bp<CR>")
map("n", "<C-w>", ":b#<CR>")
map("n", "<C-t>", ":bd")

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


-- Agrega esta función a tu archivo de configuración de Neovim en Lua (init.lua o init.vim)
function get_selected_text()
	-- Obtiene la línea y el rango de columnas de la selección
	local start_line = vim.fn.line("'<")
	local end_line = vim.fn.line("'>")
	local start_col = vim.fn.col("'<")
	local end_col = vim.fn.col("'>")

	-- Obtiene el texto seleccionado
	local selected_text = vim.fn.getline(start_line, end_line)
	local prev_text = vim.fn.strpart(selected_text[1], 0, start_col - 1)
	local next_text = vim.fn.strpart(selected_text[#selected_text], end_col)

	-- Ajusta el texto seleccionado para corregir el desplazamiento
	for i, line in ipairs(selected_text) do
		if start_line == end_line then
			selected_text[i] = vim.fn.strpart(line, start_col - 1, end_col - start_col + 1)
		elseif i == 1 then
			selected_text[i] = vim.fn.strpart(line, start_col - 1)
		elseif i == #selected_text then
			selected_text[i] = vim.fn.strpart(line, 0, end_col + 0)
		else
			selected_text[i] = line
		end
	end

	local first_char = vim.fn.strpart(selected_text[1], 0, 1)
	local last_char = vim.fn.strpart(selected_text[#selected_text], #selected_text[#selected_text] - 1)

	for j, text in ipairs(selected_text) do
		if first_char == '`' and last_char == '`' then
			if start_line == end_line then
				vim.fn.setline(start_line, prev_text .. vim.fn.strpart(text, 3, #text - 3 - 2) .. next_text)
			elseif j == 1 then
				vim.fn.setline(start_line, prev_text .. vim.fn.strpart(text, 3))
			elseif j == #selected_text then
				vim.fn.setline(end_line, vim.fn.strpart(text, 0, #text - 3 - 2) .. next_text)
			else
				vim.fn.setline(start_line + j, text)
			end
		else
			if start_line == end_line then
				vim.fn.setline(start_line, prev_text .. '`${' .. text .. '}`' .. next_text)
			elseif j == 1 then
				vim.fn.setline(start_line, prev_text .. '`${' .. text)
			elseif j == #selected_text then
				vim.fn.setline(end_line, text .. '}`' .. next_text)
			else
				vim.fn.setline(start_line + j, text)
			end
		end
	end
end

-- Asigna la función a la tecla 'z' en modo visual
vim.api.nvim_set_keymap('x', 'z', [[:lua get_selected_text()<CR>]], { noremap = true, silent = true })
