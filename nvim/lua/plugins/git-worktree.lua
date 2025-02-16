local which_key = require("which-key")

return {
  {
    "polarmutex/git-worktree.nvim",
    version = "^2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    enabled = true,
    config = function ()
      require("telescope").load_extension("git_worktree")

      which_key.add({ "<leader>gw", function()
        require("telescope").extensions.git_worktree.git_worktree()
      end, desc = "Git worktrees", mode = "n"})
    end
  }
}
