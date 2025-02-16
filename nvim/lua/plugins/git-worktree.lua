local which_key = require("which-key")

return {
  {
    "polarmutex/git-worktree.nvim",
    version = "^2",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    enabled = true,
    config = function ()
      require("telescope").load_extension("git_worktree")

      which_key.add({ "W", desc = "Git worktrees", mode = "n"})
      which_key.add({ "Wf", function()
        require("telescope").extensions.git_worktree.git_worktree()
      end, desc = "Find worktree", mode = "n"})
    end
  }
}
