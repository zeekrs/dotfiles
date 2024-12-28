-- https://github.com/mrjones2014/smart-splits.nvim
-- work with tmux
return {
  "mrjones2014/smart-splits.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {
    -- move
    {
      "<C-h>",
      function()
        require("smart-splits").move_cursor_left()
      end,
      desc = "Go to left window",
      mode = { "n" },
    },
    {
      "<C-j>",
      function()
        require("smart-splits").move_cursor_down()
      end,
      desc = "Go to lower window",
      mode = { "n" },
    },
    {
      "<C-k>",
      function()
        require("smart-splits").move_cursor_up()
      end,
      desc = "Go to upper window",
      mode = { "n" },
    },
    {
      "<C-l>",
      function()
        require("smart-splits").move_cursor_right()
      end,
      desc = "Go to right window",
      mode = { "n" },
    },
    -- resize
    {
      "<A-h>",
      function()
        require("smart-splits").resize_left()
      end,
      desc = "Decrease window width",
      mode = { "n" },
    },
    {
      "<A-j>",
      function()
        require("smart-splits").resize_down()
      end,
      desc = "Decrease window height",
      mode = { "n" },
    },
    {
      "<A-k>",
      function()
        require("smart-splits").resize_up()
      end,
      desc = "Increase window height",
      mode = { "n" },
    },
    {
      "<A-l>",
      function()
        require("smart-splits").resize_right()
      end,
      desc = "Increase window width",
      mode = { "n" },
    },
    -- swap windows
    {
      "<leader>wh",
      function()
        require("smart-splits").swap_buf_left()
      end,
      desc = "Swap buffer left",
    },
    {
      "<leader>wj",
      function()
        require("smart-splits").swap_buf_down()
      end,
      desc = "Swap buffer down",
    },
    {
      "<leader>wk",
      function()
        require("smart-splits").swap_buf_up()
      end,
      desc = "Swap buffer up",
    },
    {
      "<leader>wl",
      function()
        require("smart-splits").swap_buf_right()
      end,
      desc = "Swap buffer right",
    },
  },
}
