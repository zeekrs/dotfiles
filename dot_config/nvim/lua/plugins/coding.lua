return {
  -- override cmp keymaps
  -- nvim-snip
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end
      local cmp = require("cmp")

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      if LazyVim.has_extra("coding.luasnip") then
        local luasnip = require("luasnip")
        opts.mapping = vim.tbl_extend("force", opts.mapping, {

          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                cmp.confirm({
                  select = true,
                })
              end
            else
              fallback()
            end
          end),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        })
      else
        opts.mapping = vim.tbl_extend("force", opts.mapping, {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif vim.snippet.active({ direction = 1 }) then
              vim.schedule(function()
                vim.snippet.jump(1)
              end)
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif vim.snippet.active({ direction = -1 }) then
              vim.snippet.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        })
      end
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
  {
    "danymat/neogen",
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
    "andrewferrier/debugprint.nvim",
    opts = {
      keymaps = {
        normal = {
          plain_below = "g?p",
          plain_above = "g?P",
          variable_below = "g?v",
          variable_above = "g?V",
          variable_below_alwaysprompt = nil,
          variable_above_alwaysprompt = nil,
          textobj_below = "g?o",
          textobj_above = "g?O",
          toggle_comment_debug_prints = "g?t",
          delete_debug_prints = "g?d",
        },
        visual = {
          variable_below = "g?v",
          variable_above = "g?V",
        },
      },
      commands = {
        toggle_comment_debug_prints = "ToggleCommentDebugPrints",
        delete_debug_prints = "DeleteDebugPrints",
      },
    },
    keys = {
      { "g?", "", mode = { "n", "x" }, desc = "+debug print" },
      { "g?p", mode = "n", desc = "Plain Below" },
      { "g?P", mode = "n", desc = "Plain Above" },
      { "g?v", mode = { "n", "x" }, desc = "Variable Below" },
      { "g?V", mode = { "n", "x" }, desc = "Variable Above" },
      { "g?o", mode = "n", desc = "Textobj Below" },
      { "g?O", mode = "n", desc = "Textobj Above" },
      { "g?t", mode = "n", desc = "Toggle Comment" },
      { "g?d", mode = "n", desc = "Delete DebugPrint" },
    },
    cmd = {
      "ToggleCommentDebugPrints",
      "DeleteDebugPrints",
    },
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
  {
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "v" }, desc = "Telescope" },
    },
  },
  {
    "gbprod/yanky.nvim",
    keys = {
      {
        "<leader>p",
        function()
          if LazyVim.pick.picker.name == "telescope" then
            require("telescope").extensions.yank_history.yank_history({})
          elseif LazyVim.pick.picker.name == "fzf" then
            local fzf = require("fzf-lua")
            local histories = require("yanky.history").all()

            local make_display = function(k, v)
              return fzf.utils.ansi_codes.yellow(tostring(k))
                .. " "
                .. v.regcontents:gsub("\n", fzf.utils.ansi_codes.grey("\\n"))
            end

            local get_content = function(content_str)
              local index = string.match(content_str, "^%d+")
              return histories[tonumber(index)]
            end
            local entries = {}
            for k, v in ipairs(histories) do
              table.insert(entries, make_display(k, v))
            end

            -- previewer  https://github.com/ibhagwan/fzf-lua/wiki/Advanced#neovim-builtin-preview
            local builtin = require("fzf-lua.previewer.builtin")

            local TmpBufferPreviewer = builtin.base:extend()
            function TmpBufferPreviewer:new(o, opts, fzf_win)
              TmpBufferPreviewer.super.new(self, o, opts, fzf_win)
              setmetatable(self, TmpBufferPreviewer)
              return self
            end

            function TmpBufferPreviewer:populate_preview_buf(entry_str)
              local content = get_content(entry_str)

              local tmpbuf = self:get_tmp_buffer()

              vim.api.nvim_buf_set_lines(tmpbuf, 0, -1, true, vim.split(content.regcontents, "\n"))
              if content.filetype ~= nil then
                vim.bo[tmpbuf].filetype = content.filetype
              end

              self:set_preview_buf(tmpbuf)
              self.win:update_scrollbar()
            end

            -- Disable line numbering and word wrap
            function TmpBufferPreviewer:gen_winopts()
              local new_winopts = {
                wrap = false,
                number = false,
              }
              return vim.tbl_extend("force", self.winopts, new_winopts)
            end

            local opts = {
              fzf_opts = {
                ["--preview"] = function(items)
                  return get_content(items[1]).regcontents
                end,
                ["--no-keep-right"] = "",
              },
              previewer = TmpBufferPreviewer,
              fzf_colors = true,
              actions = {
                ["default"] = function(items)
                  require("yanky.picker").actions.put("p")(get_content(items[1]))
                end,
              },
            }
            fzf.fzf_exec(entries, opts)
          else
            vim.cmd([[YankyRingHistory]])
          end
        end,
        desc = "Open Yank History",
      },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n" }, desc = "Put yanked text after cursor" },
      { "p", "<Plug>(YankyPutBefore)", mode = { "x" }, desc = "Put yanked text after cursor without copy" },
    },
  },
}
