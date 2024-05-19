local prefix = "<leader><space>"

return {

  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        [prefix] = { name = "+harpoon" },
      },
    },
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function(_, opts)
      require("harpoon"):setup(opts)
    end,
    keys = function()
      -- basic telescope configuration
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
        {
          prefix .. "a",
          function()
            require("harpoon"):list():add()
          end,
          desc = "Add file",
        },
        {
          prefix .. "d",
          function()
            require("harpoon"):list():remove()
          end,
          desc = "Remove file",
        },
        {
          prefix .. "c",
          function()
            require("harpoon"):list():clear()
          end,
          desc = "Clear files",
        },
        {
          prefix .. "e",
          function()
            require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
          end,
          desc = "Toggle quick menu",
        },
        {
          prefix .. "t",
          function()
            toggle_telescope(require("harpoon"):list())
          end,
          desc = "Toggle telescope",
        },
        {
          prefix .. "g",
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
        { prefix .. "m", "<cmd>Telescope harpoon marks<CR>", desc = "Show marks in Telescope" },
      }

      for i = 1, 5 do
        table.insert(keys, {
          prefix .. i,
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
