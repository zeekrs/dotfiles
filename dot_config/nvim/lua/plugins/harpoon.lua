return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local conf = require("telescope.config").values
      local function toggle_telescope(harpoon_files)
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end
      local keys = {
        { "<leader><space>", "", desc = "+harpoon" },
        {
          "<leader><space>a",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Add file",
        },
        {
          "<leader><space>d",
          function()
            require("harpoon"):list():remove()
          end,
          desc = "Remove file",
        },
        {
          "<leader><space>c",
          function()
            require("harpoon"):list():clear()
          end,
          desc = "Clear files",
        },
        {
          "<leader><space>e",
          function()
            require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
          end,
          desc = "Toggle quick menu",
        },
        {
          "<leader><space>t",
          function()
            toggle_telescope(require("harpoon"):list())
          end,
          desc = "Toggle telescope",
        },
        {
          "<leader><space>g",
          function()
            vim.ui.input({ prompt = "Harpoon mark index: " }, function(input)
              local num = tonumber(input)
              if num then
                require("harpoon"):list():select(num)
              end
            end)
          end,
          desc = "Goto index of mark",
        },
        { "<leader><space>m", "<cmd>Telescope harpoon marks<CR>", desc = "Show marks in Telescope" },
      }

      for i = 1, 5 do
        table.insert(keys, {
          "<leader><space>" .. i,
          function()
            require("harpoon"):list():select(i)
          end,
          desc = "Harpoon to File " .. i,
        })
      end

      return keys
    end,
  },
}
