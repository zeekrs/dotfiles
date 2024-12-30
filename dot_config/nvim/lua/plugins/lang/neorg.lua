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
    dependencies = {
      "luarocks.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-neorg/neorg-telescope",
      "benlubas/neorg-interim-ls",
    },
    event = { "BufReadPre *.norg", "BufNewFile *.norg" },
    enabled = true,
    keys = {
      { "<leader>o", "", desc = "+org" },
      { "<leader>on", "<Plug>(neorg.dirman.new-note)", desc = "Create New Note" },
      { "<leader>ow", "<cmd>Telescope neorg switch_workspace<CR>", desc = "Switch Workspace" },
      { "<leader>of", "<cmd>Telescope neorg find_norg_files<CR>", desc = "Find Files" },
      { "<leader>oi", "<cmd>Neorg index<CR>", desc = "Go to index" },
      { "<leader>or", "<cmd>Neorg return<CR>", desc = "Return" },
      { "<leader>oj", "<cmd>Neorg journal today<CR>", desc = "Journal" },
    },
    config = function()
      -- -- add keymap for neorg
      vim.api.nvim_create_autocmd("Filetype", {
        pattern = "norg",
        callback = function()
          -- Normal mode
          -- ^^Jump^^
          -- Hop to the destination of the link under the cursor
          vim.keymap.set("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { buffer = true, desc = "Jump to Link" })
          -- Same as `<CR>`, except open the destination in a vertical split
          vim.keymap.set(
            "n",
            "<M-CR>",
            "<Plug>(neorg.esupports.hop.hop-link.vsplit)",
            { buffer = true, desc = "Jump to Link (Vertical Split)" }
          )
          -- Same as `<CR>`, except open the destination in a new tab
          vim.keymap.set(
            "n",
            "<M-t>",
            "<Plug>(neorg.esupports.hop.hop-link.tab-drop)",
            { buffer = true, desc = "Jump to Link (Tab Drop)" }
          )

          -- Promote an object non-recursively
          vim.keymap.set(
            "n",
            ">.",
            "<Plug>(neorg.promo.promote)",
            { buffer = true, desc = "Promote Object (Non-Recursively)" }
          )
          -- Demote an object non-recursively
          vim.keymap.set(
            "n",
            "<,",
            "<Plug>(neorg.promo.demote)",
            { buffer = true, desc = "Demote Object(Non-Recursively)" }
          )
          -- Promote an object recursively
          vim.keymap.set(
            "n",
            ">>",
            "<Plug>(neorg.promo.promote.nested)",
            { buffer = true, desc = "Promote Object (Recursively)" }
          )
          -- Demote an object recursively
          vim.keymap.set(
            "n",
            "<<",
            "<Plug>(neorg.promo.demote.nested)",
            { buffer = true, desc = "Demote Object (Recursively)" }
          )

          --^^Task^^
          vim.keymap.set("n", "<LocalLeader>t", "", { buffer = true, desc = "+task" })
          -- ^mark Task as Undone
          vim.keymap.set(
            "n",
            "<LocalLeader>tu",
            "<Plug>(neorg.qol.todo-items.todo.task-undone)",
            { buffer = true, desc = "Mark as Undone" }
          )
          -- ^mark Task as Pending
          vim.keymap.set(
            "n",
            "<LocalLeader>tp",
            "<Plug>(neorg.qol.todo-items.todo.task-pending)",
            { buffer = true, desc = "Mark as Undone" }
          )
          -- ^mark Task as Done
          vim.keymap.set(
            "n",
            "<LocalLeader>td",
            "<Plug>(neorg.qol.todo-items.todo.task-done)",
            { buffer = true, desc = "Mark as Undone" }
          )
          -- ^mark Task as on Hold
          vim.keymap.set(
            "n",
            "<LocalLeader>th",
            "<Plug>(neorg.qol.todo-items.todo.task-hold)",
            { buffer = true, desc = "Mark as on Hold" }
          )
          -- ^mark Task as Cancelled
          vim.keymap.set(
            "n",
            "<LocalLeader>tc",
            "<Plug>(neorg.qol.todo-items.todo.task-cancelled)",
            { buffer = true, desc = "Mark as Cancelled" }
          )
          -- ^mark Task as Recurring
          vim.keymap.set(
            "n",
            "<LocalLeader>ti",
            "<Plug>(neorg.qol.todo-items.todo.task-recurring)",
            { buffer = true, desc = "Mark as Recurring" }
          )
          -- ^mark Task as Important
          vim.keymap.set(
            "n",
            "<LocalLeader>ti",
            "<Plug>(neorg.qol.todo-items.todo.task-important)",
            { buffer = true, desc = "Mark as Important" }
          )

          -- ^mark Task as Ambiguous
          vim.keymap.set(
            "n",
            "<LocalLeader>ta",
            "<Plug>(neorg.qol.todo-items.todo.task-ambiguous)",
            { buffer = true, desc = "Mark as Ambiguous" }
          )
          -- Switch the task under the cursor between a select few states
          vim.keymap.set(
            "n",
            "<C-q>",
            "<Plug>(neorg.qol.todo-items.todo.task-cycle)",
            { buffer = true, desc = "Mark Circle" }
          )

          -- ^^List^^
          vim.keymap.set("n", "<LocalLeader>l", "", { buffer = true, desc = "+list" })
          -- Toggle a list from ordered <-> unordered
          vim.keymap.set(
            "n",
            "<LocalLeader>lt",
            "<Plug>(neorg.pivot.list.toggle)",
            { buffer = true, desc = "Toggle (Un)ordered List" }
          )
          -- Invert all items in a list
          vim.keymap.set(
            "n",
            "<LocalLeader>li",
            "<Plug>(neorg.pivot.list.invert)",
            { buffer = true, desc = "Invert (Un)ordered List" }
          )
          -- ^^Insert^^
          vim.keymap.set("n", "<LocalLeader>i", "", { buffer = true, desc = "+insert" })
          vim.keymap.set(
            "n",
            "<LocalLeader>id",
            "<Plug>(neorg.tempus.insert-date)",
            { buffer = true, desc = "Insert Date" }
          )
          -- ^^Code^^
          vim.keymap.set("n", "<LocalLeader>c", "", { buffer = true, desc = "+code" })
          -- ^Code Magnify
          vim.keymap.set(
            "n",
            "<LocalLeader>cm",
            "<Plug>(neorg.looking-glass.magnify-code-block)",
            { buffer = true, desc = "Magnify Code Block" }
          )

          -- Toggle concealer
          vim.keymap.set(
            "n",
            "<LocalLeader>C",
            "<cmd>Neorg toggle-concealer<CR>",
            { buffer = true, desc = "Toggle concealer" }
          )

          -- ^^export^^
          vim.keymap.set("n", "<LocalLeader>e", "", { buffer = true, desc = "+export" })
          -- Export to file
          vim.keymap.set(
            "n",
            "<LocalLeader>ef",
            "<cmd>Neorg export to-file<CR>",
            { buffer = true, desc = "Export File" }
          )
          -- Export to directory
          vim.keymap.set(
            "n",
            "<LocalLeader>ed",
            "<cmd>Neorg export directory<CR>",
            { buffer = true, desc = "Export Directory" }
          )

          -- ^^meta^^
          vim.keymap.set("n", "<LocalLeader>m", "", { buffer = true, desc = "+meta" })
          -- Metadata Inject
          vim.keymap.set(
            "n",
            "<LocalLeader>mi",
            "<cmd>Neorg inject-metadata<CR>",
            { buffer = true, desc = "Neorg metadata inject" }
          )
          -- Metadata Update
          vim.keymap.set(
            "n",
            "<LocalLeader>mu",
            "<cmd>Neorg update-metadata<CR>",
            { buffer = true, desc = "Neorg metadata update" }
          )
          -- ^^Journal^^
          vim.keymap.set("n", "<LocalLeader>j", "", { buffer = true, desc = "+journal" })
          -- Journal Today
          vim.keymap.set("n", "<LocalLeader>jt", "<cmd>Neorg journal today<CR>", { buffer = true, desc = "Today" })
          -- Journal Yesterday
          vim.keymap.set(
            "n",
            "<LocalLeader>jy",
            "<cmd>Neorg journal yesterday<CR>",
            { buffer = true, desc = "Yesterday" }
          )
          -- Journal Tommorro
          vim.keymap.set("n", "<LocalLeader>jn", "<cmd>Neorg journal tomorrow<CR>", { buffer = true, desc = "Nextday" })
          -- Journal Custom
          vim.keymap.set("n", "<LocalLeader>jc", "<cmd>Neorg journal custom<CR>", { buffer = true, desc = "Custom" })
          -- ^^Summary^^'
          vim.keymap.set(
            "n",
            "<LocalLeader>s",
            "<cmd>Neorg generate-workspace-summary<CR>",
            { buffer = true, desc = "Summary" }
          )

          -- ^^Find^^
          vim.keymap.set("n", "<LocalLeader>f", "", { buffer = true, desc = "+find" })
          -- Find Linkable
          vim.keymap.set(
            "n",
            "<LocalLeader>fl",
            "<Plug>(neorg.telescope.find_linkable)",
            { buffer = true, desc = "Find Linkable" }
          )
          -- Find a heading
          vim.keymap.set(
            "n",
            "<LocalLeader>fh",
            "<Plug>(neorg.telescope.search_headings)",
            { buffer = true, desc = "Find Heading" }
          )
          -- Insert File Link
          vim.keymap.set(
            "n",
            "<LocalLeader>if",
            "<Plug>(neorg.telescope.insert_file_link)",
            { buffer = true, desc = "Insert File Link" }
          )
          -- Insert Link
          vim.keymap.set(
            "n",
            "<LocalLeader>il",
            "<Plug>(neorg.telescope.insert_link)",
            { buffer = true, desc = "Insert Link" }
          )

          -- Insert mode
          -- Promote an object recursively
          vim.keymap.set(
            "i",
            "<C-t>",
            "<Plug>(neorg.promo.promote)",
            { buffer = true, desc = "Promote Object (Recursively)" }
          )
          -- Demote an object recursively
          vim.keymap.set(
            "i",
            "<C-d>",
            "<Plug>(neorg.promo.demote)",
            { buffer = true, desc = "Demote Object (Recursively)" }
          )
          -- Create an iteration of e.g. a list item
          vim.keymap.set(
            "i",
            "<M-CR>",
            "<Plug>(neorg.itero.next-iteration)",
            { buffer = true, desc = "Continue Object" }
          )
          -- Insert a link to a date at the current cursor position
          -- ^Date
          vim.keymap.set(
            "i",
            "<M-d>",
            "<Plug>(neorg.tempus.insert-date.insert-mode)",
            { buffer = true, desc = "Insert Date" }
          )

          -- Visual mode
          -- Promote objects in range
          vim.keymap.set(
            "v",
            ">",
            "<Plug>(neorg.promo.promote.range)",
            { buffer = true, desc = "Promote Objects in Range" }
          )
          -- Demote objects in range
          vim.keymap.set(
            "v",
            "<",
            "<Plug>(neorg.promo.demote.range)",
            { buffer = true, desc = "Demote Objects in Range" }
          )
        end,
      })

      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.keybinds"] = {
            config = {
              default_keybinds = false,
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
              engine = { module_name = "external.lsp-completion" },
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
          ["external.interim-ls"] = {
            config = {
              -- default config shown
              completion_provider = {
                -- Enable or disable the completion provider
                enable = true,

                -- Show file contents as documentation when you complete a file name
                documentation = true,

                -- Try to complete categories provided by Neorg Query. Requires `benlubas/neorg-query`
                categories = false,

                -- suggest heading completions from the given file for `{@x|}` where `|` is your cursor
                -- and `x` is an alphanumeric character. `{@name}` expands to `[name]{:$/people:# name}`
                people = {
                  enable = false,

                  -- path to the file you're like to use with the `{@x` syntax, relative to the
                  -- workspace root, without the `.norg` at the end.
                  -- ie. `folder/people` results in searching `$/folder/people.norg` for headings.
                  -- Note that this will change with your workspace, so it fails silently if the file
                  -- doesn't exist
                  path = "people",
                },
              },
            },
          },
        },
      })
    end,
  },
}
