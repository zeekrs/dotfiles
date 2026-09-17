return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>sp",
        function()
          require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.expand("%") } })
        end,
        desc = "Replace in Current Files",
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
}
