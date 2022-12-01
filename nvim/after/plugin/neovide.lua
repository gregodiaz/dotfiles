vim.g.neovide_transparency=0.96
vim.g.neovide_refresh_rate = 60
vim.g.neovide_confirm_quit = 1 -- 1 = true

vim.g.neovide_scroll_animation_length = 0.69
vim.g.neovide_cursor_animation_length=0.069
vim.g.neovide_cursor_trail_size=0.69
vim.o.winblend = 43
vim.o.pumblend = 100

-- GUI Font
vim.g.gui_font_default_size = 12
vim.g.gui_font_size = vim.g.gui_font_default_size
vim.g.gui_font_face = "Operator Mono SSm Lig Book"
-- vim.g.gui_font_face = "Operator Mono SSm Lig Medium"

RefreshGuiFont = function()
    vim.opt.guifont = string.format("%s:h%s", vim.g.gui_font_face, vim.g.gui_font_size)
end

ResizeGuiFont = function(delta)
    vim.g.gui_font_size = vim.g.gui_font_size + delta
    RefreshGuiFont()
end

ResetGuiFont = function()
    vim.g.gui_font_size = vim.g.gui_font_default_size
    RefreshGuiFont()
end

-- Call function on startup to set default value
ResetGuiFont()

-- Keymaps
local opts = { noremap = true, silent = true }

vim.keymap.set({ 'n', 'i' }, "<C-+>", function() ResizeGuiFont(1) end, opts)
vim.keymap.set({ 'n', 'i' }, "<C-->", function() ResizeGuiFont(-1) end, opts)
