require('telescope').setup {
    defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                ["<C-h>"] = "which_key",
                -- ["<CR>"] = "select_tab",
            }
        },
        file_ignore_patterns = { "vendor" }
    },
    hidden = true,
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
    }
}


vim.keymap.set('n', '<leader>po', require "telescope.builtin".find_files, { remap = false })
vim.keymap.set('n', '<leader>pp', require "telescope.builtin".git_files, { remap = false })
vim.keymap.set('n', '<leader>gs', require "telescope.builtin".git_status, { remap = false })
vim.keymap.set('n', '<leader>gc', require "telescope.builtin".git_commits, { remap = false })

vim.keymap.set('n', '<leader>tb', require "telescope.builtin".git_branches, { remap = false })
vim.keymap.set('n', '<leader>tt', require "telescope.builtin".buffers, { remap = false })
vim.keymap.set('n', '<leader>tg', require "telescope.builtin".live_grep, { remap = false })
vim.keymap.set('n', '<leader>tg', require "telescope.builtin".live_grep, { remap = false })
