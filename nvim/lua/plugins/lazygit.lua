return {
  "kdheepak/lazygit.nvim",
  enabled = false,
  keys = { { "<leader>gy", ":LazyGit<cr>" } },
  config = function()
    vim.env.GIT_EDITOR = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
  end,
}
