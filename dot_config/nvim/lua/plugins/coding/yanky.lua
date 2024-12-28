return {
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
}
