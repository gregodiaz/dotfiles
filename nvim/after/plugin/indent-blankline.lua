vim.opt.list = true
vim.opt.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent guifg=#2f2f2f gui=nocombine]]
-- vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

require("indent_blankline").setup {
    -- space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
    char_highlight_list = { "IndentBlanklineIndent", },
}
