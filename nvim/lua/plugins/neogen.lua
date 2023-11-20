return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  cmd = { "Neogen" },
  keys = {{"<leader>nn", ":Neogen<cr>"}},
  opts = { snippet_engine = "luasnip" },
}
