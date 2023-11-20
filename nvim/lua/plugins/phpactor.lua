return {
  "gbprod/phpactor.nvim",
	enabled = false,
  cmd = { "PhpActor" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    install = {
      bin = vim.fn.stdpath("data") .. "/mason/bin/phpactor",
    },
    lsp_config = {
      enable = false,
    },
  },
}
