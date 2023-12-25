return {
  -- override cmp keymaps
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      -- auto pairs <cr>
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
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
    "echasnovski/mini.comment",
    enabled = false,
  },
  {
    "numToStr/Comment.nvim",
    opts = {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    },
    event = "VeryLazy",
  },
  {
    "danymat/neogen",
    opts = {
      snippet_engine = "luasnip",
    },
    keys = {
      {
        "<leader>cg",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen",
      },
    },
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      { "p", "<Plug>(YankyPutAfter)", mode = { "n" }, desc = "Put yanked text after cursor" },
      { "p", "<Plug>(YankyPutBefore)", mode = { "x" }, desc = "Put yanked text after cursor without copy" },
    },
  },
  {
    "chrisgrieser/nvim-spider",
    keys = {
      {
        "w",
        function()
          require("spider").motion("w")
        end,
        mode = { "n", "o", "x" },
      },
      {
        "w",
        function()
          ---@diagnostic disable-next-line: missing-fields
          require("spider").motion("w", { skipInsignificantPunctuation = false })
        end,
        mode = { "o" },
      },
      {
        "e",
        function()
          require("spider").motion("e")
        end,
        mode = { "n", "x" },
      },
      {
        "e",
        function()
          ---@diagnostic disable-next-line: missing-fields
          require("spider").motion("e", { skipInsignificantPunctuation = false })
        end,
        mode = { "o" },
      },
      {
        "b",
        function()
          require("spider").motion("b")
        end,
        mode = { "n", "x" },
      },

      {
        "b",
        function()
          ---@diagnostic disable-next-line: missing-fields
          require("spider").motion("b", { skipInsignificantPunctuation = false })
        end,
        mode = { "o" },
      },
      {
        "ge",
        function()
          require("spider").motion("ge")
        end,
        mode = { "n", "x" },
      },

      {
        "ge",
        function()
          ---@diagnostic disable-next-line: missing-fields
          require("spider").motion("ge", { skipInsignificantPunctuation = false })
        end,
        mode = { "o" },
      },
    },
  },

  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>re",
        function()
          require("refactoring").refactor("Extract Function")
        end,
        mode = "x",
        desc = "Extract function",
      },
      {
        "<leader>rf",
        function()
          require("refactoring").refactor("Extract Function To File")
        end,
        mode = "x",
        desc = "Extract function to file",
      },
      {
        "<leader>rv",
        function()
          require("refactoring").refactor("Extract Variable")
        end,
        mode = "x",
        desc = "Extract variable",
      },
      {
        "<leader>rI",
        function()
          require("refactoring").refactor("Inline Function")
        end,
        mode = "n",
        desc = "Inline function",
      },
      {
        "<leader>ri",
        function()
          require("refactoring").refactor("Inline Variable")
        end,
        mode = { "x", "n" },
        desc = "Inline variable",
      },
      {
        "<leader>rb",
        function()
          require("refactoring").refactor("Extract Block")
        end,
        mode = "n",
        desc = "Extract block",
      },
      {
        "<leader>rf",
        function()
          require("refactoring").refactor("Extract Block To File")
        end,
        mode = "n",
        desc = "Extract block to file",
      },

      {
        "<leader>rr",
        function()
          require("telescope").extensions.refactoring.refactors()
        end,
        mode = { "n", "x" },
        desc = "Extract block to file",
      },
    },
    config = true,
  },

  {
    "andrewferrier/debugprint.nvim",
    opts = {},
    version = "*",
  },
  -- Split Join code block
  {
    "Wansmer/treesj",
    keys = {
      {
        "J",
        function()
          require("treesj").toggle()
        end,
        mode = { "n" },
        desc = "Toggle split/join",
      },
    },
    opts = {
      use_default_keymaps = false,
      max_join_length = 65536,
    },
  },
  -- Better increase/descrease
  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<C-a>",
        function()
          return require("dial.map").manipulate("increment", "normal")
        end,
        desc = "Increment",
        mode = "n",
      },
      {
        "<C-x>",
        function()
          return require("dial.map").manipulate("decrement", "normal")
        end,
        desc = "Decrement",
        mode = "n",
      },
      {
        "g<C-a>",
        function()
          return require("dial.map").manipulate("increment", "gnormal")
        end,
        desc = "Increment",
        mode = "n",
      },
      {
        "g<C-x>",
        function()
          return require("dial.map").manipulate("decrement", "gnormal")
        end,
        desc = "Decrement",
        mode = "n",
      },

      {
        "<C-a>",
        function()
          return require("dial.map").manipulate("increment", "visual")
        end,
        desc = "Increment",
        mode = "v",
      },
      {
        "<C-x>",
        function()
          return require("dial.map").manipulate("decrement", "visual")
        end,
        desc = "Decrement",
        mode = "v",
      },
      {
        "g<C-a>",
        function()
          return require("dial.map").manipulate("increment", "gvisual")
        end,
        desc = "Increment",
        mode = "v",
      },
      {
        "g<C-x>",
        function()
          return require("dial.map").manipulate("decrement", "gvisual")
        end,
        desc = "Decrement",
        mode = "v",
      },
    },
  },
}
