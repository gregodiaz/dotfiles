vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.cursorline = true
vim.o.clipboard = "unnamedplus"

-- Airline
vim.g.airline_extensions_whitespace_enabled = 1
vim.g.airline_extensions_tabline_enabled = 0
vim.g.airline_extensions_bufferline_enabled = 1
vim.g.airline_extensions_branch_enabled = 1
vim.g.airline_detect_modified = 1
-- vim.g.airline_section_b = '%-0.14{getcwd()}'
-- vim.g.airline_section_x = '%P'
-- vim.g.airline_section_y = '%B'
vim.g.airline_section_z = "%3p%% %l/%L:%v"
vim.g.airline_left_sep = ""
vim.g.airline_left_alt_sep = ""
vim.g.airline_right_sep = ""
vim.g.airline_right_alt_sep = ""
vim.g.airline_theme = "base16"

require "plugins"
