-- reset c-space to c-m
-- because use c-space tmux leader key
return {
  {
    "nvim-treesitter/nvim-treesitter",
    keys = {
      { "<CR>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, opts)
      -- do not use apple gcc
      require("nvim-treesitter.install").compilers = { "gcc-12" }
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
