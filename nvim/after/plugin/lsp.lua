require("nvim-lsp-installer").setup {
    automatic_installation = true
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<C-s>', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '<C-d>', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', '<C-f>', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<C-a>', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<Leader>rl', ':LspRestart<CR>', { noremap = true })

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'vf', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'vd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set({'n', 'i'}, '<F1>', vim.lsp.buf.hover, bufopts)
    vim.keymap.set({'n', 'i'}, '<F2>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<Leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<Leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<Leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<Leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<Leader>f', vim.lsp.buf.format, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

local lspconfig = require("lspconfig")


lspconfig.intelephense.setup {
    on_attach = on_attach,
    flags = lsp_flags,
}

-- lspconfig.phpactor.setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }

lspconfig.tsserver.setup {
    on_attach = on_attach,
    flags = lsp_flags,
}

lspconfig.emmet_ls.setup {
    on_attach = on_attach,
    flags = lsp_flags,
}

lspconfig.sumneko_lua.setup {
    on_attach = on_attach,
    flags = lsp_flags,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}
