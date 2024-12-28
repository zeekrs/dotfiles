return {
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      -- check_ts = true,
      fast_wrap = {},
    },
    keys = {
      {
        "<leader>up",
        function()
          local Util = require("lazy.core.util")
          local autopairs = require("nvim-autopairs")
          local disabled = autopairs.state.disabled
          if disabled then
            Util.info("Enabled auto pairs", { title = "Option" })
            autopairs.enable()
          else
            Util.warn("Disabled  auto pairs", { title = "Option" })
            autopairs.disable()
          end
        end,
        desc = "Toggle auto pairs",
      },
    },
  },
  {
    "folke/ts-comments.nvim",
    enabled = false,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
  },
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    opts = function()
      return {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
    event = "VeryLazy",
  },
}
