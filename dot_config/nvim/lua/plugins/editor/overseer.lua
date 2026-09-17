return {
  {
    "stevearc/overseer.nvim",
    keys = {
      { "<leader>ow", false },
      { "<leader>oi", false },
      { "<leader>ot", false },
      { "<leader>ol", "<cmd>OverseerToggle<cr>", desc = "Task list" },
      { "<leader>oa", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
      { "<leader>oI", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>o", group = "+org/overseer" },
      },
    },
  },
}
