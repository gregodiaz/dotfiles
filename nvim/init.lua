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

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

vim.api.nvim_create_user_command("Replace", function()
    print "Replace starts now..."
    local bufnr = vim.fn.input "Bufnr: "
    print(" you choose:", bufnr)
end, {})

require "plugins"
