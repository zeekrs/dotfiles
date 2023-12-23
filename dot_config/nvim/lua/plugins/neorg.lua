local prefix = "<leader>o"
local keys = require("config.keys")
return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        [prefix] = { name = "+org" },
      },
    },
  },
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { { "nvim-neorg/neorg-telescope" } },
    event = { "BufReadPre *.norg", "BufNewFile *.norg" },
    keys = {
      { prefix .. "w", "<cmd>Telescope neorg switch_workspace<CR>", desc = "Switch Workspace" },
      { prefix .. "f", "<cmd>Telescope neorg find_norg_files<CR>", desc = "Find Files" },
      { prefix .. "i", "<cmd>Neorg index<CR>", desc = "Go to index" },
      { prefix .. "r", "<cmd>Neorg return<CR>", desc = "Return" },
      { prefix .. "j", "<cmd>Neorg journal today<CR>", desc = "Journal" },
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
          -- NOTE: works neovim 0.10
          -- ["core.ui.calendar"] = {},
          ["core.integrations.telescope"] = {},
        },
      })
    end,
  },
}
