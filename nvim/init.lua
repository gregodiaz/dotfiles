vim.g.mapleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.cursorline = true
vim.o.clipboard = "unnamedplus"

local tabAll = 4
local tabJs = 2

vim.o.tabstop = tabAll
vim.o.softtabstop = tabAll
vim.o.shiftwidth = tabAll
vim.o.expandtab = false

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact", },
    callback = function()
	    vim.opt_local.tabstop = tabJs
        vim.opt_local.softtabstop = tabJs
        vim.opt_local.shiftwidth = tabJs
    end
})

vim.api.nvim_create_user_command("Replace", function()
	local fname = vim.ui.input({ prompt = "File: " }, function(fname)
        print(fname)
    end)

    local args = vim.fn.argv()
    for _, arg in ipairs(args) do
        print(arg)
    end
end, {})


vim.api.nvim_create_user_command("ChangeUnit", function()
    vim.ui.input({ prompt = "unit: ", default = "px" }, function(unit)
        print(unit)
    end)
end, {})

require'lspconfig'.pyright.setup{}
require "plugins"
