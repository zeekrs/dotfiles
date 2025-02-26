return {
  "gbprod/yanky.nvim",
  keys = {
    {
      "<leader>p",
      function()
        if LazyVim.pick.picker.name == "telescope" then
          require("telescope").extensions.yank_history.yank_history({})
        elseif LazyVim.pick.picker.name == "snacks" then
          local histories = require("yanky.history").all()
          ---@type snacks.picker.finder.Item[]
          local finder_items = {}
          for idx, item in ipairs(histories) do
            local text = item.regcontents
            table.insert(finder_items, {
              formatted = text,
              text = idx .. " " .. text,
              item = item,
              idx = idx,
              preview = {
                text = text,
                ft = item.filetype,
              },
            })
          end
          require("snacks").picker.pick({
            items = finder_items,
            title = "Yank History",
            preview = "preview",
            format = Snacks.picker.format.ui_select(nil, #finder_items),
            actions = {
              confirm = function(picker, item)
                picker:close()
                vim.schedule(function()
                  require("yanky.picker").actions.put("p")(item.item)
                end)
              end,
            },
          })
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
