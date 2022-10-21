require("laravel").setup({
    split_cmd = "vertical",
    split_width = 120,
    bind_telescope = true,
    ask_for_args = true,
})

require("telescope").load_extension "laravel"
