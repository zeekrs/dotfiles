return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
  -- https://github.com/pysan3/Norg-Tutorial/blob/main/MIGRATION-v8.md
  -- NOTE:  Run :Lazy build neorg
  {
    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim", "nvim-neorg/neorg-telescope" },
    event = { "BufReadPre *.norg", "BufNewFile *.norg" },
    enabled = true,
    keys = {
      { "<leader>o", "", desc = "+org" },
      { "<leader>ow", "<cmd>Telescope neorg switch_workspace<CR>", desc = "Switch Workspace" },
      { "<leader>of", "<cmd>Telescope neorg find_norg_files<CR>", desc = "Find Files" },
      { "<leader>oi", "<cmd>Neorg index<CR>", desc = "Go to index" },
      { "<leader>or", "<cmd>Neorg return<CR>", desc = "Return" },
      { "<leader>oj", "<cmd>Neorg journal today<CR>", desc = "Journal" },
    },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                keybinds.map("norg", "n", keybinds.leader .. "t", "none", { desc = "+task" })
                keybinds.map("norg", "n", keybinds.leader .. "i", "none", { desc = "+insert" })
                keybinds.map("norg", "n", keybinds.leader .. "l", "none", { desc = "+list" })
                keybinds.map("norg", "n", keybinds.leader .. "m", "none", { desc = "+mode/meta" })
                keybinds.map("norg", "n", keybinds.leader .. "n", "none", { desc = "+new" })
                keybinds.map("norg", "n", keybinds.leader .. "e", "none", { desc = "+export" })
                keybinds.map("norg", "n", keybinds.leader .. "j", "none", { desc = "+journal" })
                keybinds.map("norg", "n", keybinds.leader .. "r", "<cmd>Neorg return<CR>", { desc = "Return" })
                keybinds.map(
                  "norg",
                  "n",
                  keybinds.leader .. "g",
                  "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<CR>",
                  { desc = "Glass Code" }
                )
                keybinds.map(
                  "norg",
                  "n",
                  keybinds.leader .. "c",
                  "<cmd>Neorg toggle-concealer<CR>",
                  { desc = "Toggle concealer" }
                )
                keybinds.map(
                  "norg",
                  "n",
                  keybinds.leader .. "ef",
                  "<cmd>Neorg export to-file<CR>",
                  { desc = "Export File" }
                )
                keybinds.map(
                  "norg",
                  "n",
                  keybinds.leader .. "ed",
                  "<cmd>Neorg export directory<CR>",
                  { desc = "Export Directory" }
                )

                keybinds.map_event(
                  "norg",
                  "n",
                  keybinds.leader .. "tt",
                  "core.qol.todo_items.todo.task_cycle",
                  { desc = "Mark Circle" }
                )

                keybinds.map(
                  "norg",
                  "n",
                  keybinds.leader .. "mi",
                  "<cmd>Neorg inject-metadata<CR>",
                  { desc = "Neorg metadata inject" }
                )

                keybinds.map(
                  "norg",
                  "n",
                  keybinds.leader .. "mu",
                  "<cmd>Neorg inject-metadata<CR>",
                  { desc = "Neorg metadata update" }
                )

                keybinds.map("norg", "n", keybinds.leader .. "jt", "<cmd>Neorg journal today<CR>", { desc = "Today" })
                keybinds.map(
                  "norg",
                  "n",
                  keybinds.leader .. "jy",
                  "<cmd>Neorg journal yesterday<CR>",
                  { desc = "Yesterday" }
                )

                keybinds.map(
                  "norg",
                  "n",
                  keybinds.leader .. "jn",
                  "<cmd>Neorg journal tommorro<CR>",
                  { desc = "Tommorro" }
                )

                keybinds.map("norg", "n", keybinds.leader .. "jc", "<cmd>Neorg journal custom<CR>", { desc = "Custom" })

                keybinds.map(
                  "norg",
                  "n",
                  keybinds.leader .. "s",
                  "<cmd>Neorg generate-workspace-summary<CR>",
                  { desc = "Summary" }
                )
                -- telescope
                keybinds.map_event(
                  "norg",
                  "n",
                  keybinds.leader .. "f",
                  "core.integrations.telescope.find_linkable",
                  { desc = "Find Linkable" }
                )

                keybinds.map_event(
                  "norg",
                  "n",
                  keybinds.leader .. "if",
                  "core.integrations.telescope.insert_file_link",
                  { desc = "Find Linkable" }
                )

                keybinds.map_event(
                  "norg",
                  "n",
                  keybinds.leader .. "il",
                  "core.integrations.telescope.insert_link",
                  { desc = "Insert Link" }
                )

                keybinds.map_event(
                  "norg",
                  "i",
                  "<C-l>",
                  "core.integrations.telescope.insert_link",
                  { desc = "Insert Link" }
                )
              end,
            },
          },
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/Documents/Notes",
              },
              default_workspace = "notes",
            },
          },

          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
              name = "Neorg",
            },
          },
          ["core.export"] = {},
          ["core.export.markdown"] = {
            config = { extensions = "all" },
          },
          ["core.summary"] = {},
          ["core.ui.calendar"] = {},
          ["core.integrations.telescope"] = {},
        },
      })
    end,
  },
}
