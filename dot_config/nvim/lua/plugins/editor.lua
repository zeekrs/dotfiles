local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr, _)
      local actions = require("telescope.actions")
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename, function() end)
      end)
      return true
    end,
  }
end
return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- disable the keymap for find files
      { "<leader><space>", false },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {},
      filesystem = {
        window = {
          mappings = {
            ["d"] = "trash",
            ["O"] = "system_open",
            ["f"] = "none",
            ["ff"] = "telescope_find",
            ["fg"] = "telescope_grep",
          },
        },
        commands = {
          system_open = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            -- macOs: open file in default application in the background.
            -- -g, --background      Does not bring the application to the foreground.
            vim.fn.jobstart({ "open", "-g", path }, { detach = true })
          end,
          telescope_find = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            if node.type == "directory" then
              require("telescope.builtin").find_files(getTelescopeOpts(state, path))
            else
              vim.notify("find file only work on directory", vim.log.levels.WARN)
            end
          end,
          telescope_grep = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            if node.type == "directory" then
              require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
            else
              vim.notify("find grep only work on directory", vim.log.levels.WARN)
            end
          end,
          trash = function(state)
            local tree = state.tree
            local node = tree:get_node()
            if node.type == "message" then
              return
            end
            local _, name = require("neo-tree.utils").split_path(node.path)
            local msg = string.format("Are you sure you want to trash '%s'?", name)
            require("neo-tree.ui.inputs").confirm(msg, function(confirmed)
              if not confirmed then
                return
              end
              vim.api.nvim_command("silent !trash -F " .. node.path)
              require("neo-tree.sources.filesystem.commands").refresh(state)
            end)
          end,
          trash_visual = function(state, selected_nodes)
            local paths_to_trash = {}
            for _, node in ipairs(selected_nodes) do
              if node.type ~= "message" then
                table.insert(paths_to_trash, node.path)
              end
            end
            local msg = "Are you sure you want to trash " .. #paths_to_trash .. " items?"
            require("neo-tree.ui.inputs").confirm(msg, function(confirmed)
              if not confirmed then
                return
              end
              for _, path in ipairs(paths_to_trash) do
                vim.api.nvim_command("silent !trash -F " .. path)
              end
              require("neo-tree.sources.filesystem.commands").refresh(state)
            end)
          end,
        },
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
      on_open = function(term)
        -- move cursor
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "t",
          "<C-h>",
          "<cmd>lua require('smart-splits').move_cursor_left()<CR>",
          { noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "t",
          "<C-j>",
          "<cmd>lua require('smart-splits').move_cursor_down()<CR>",
          { noremap = true, silent = true }
        )

        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "t",
          "<C-k>",
          "<cmd>lua require('smart-splits').move_cursor_up()<CR>",
          { noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "t",
          "<C-l>",
          "<cmd>lua require('smart-splits').move_cursor_right()<CR>",
          { noremap = true, silent = true }
        )
        -- reseize
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "t",
          "<A-h>",
          "<cmd>lua require('smart-splits').resize_left()<CR>",
          { noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "t",
          "<A-j>",
          "<cmd>lua require('smart-splits').resize_up()<CR>",
          { noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "t",
          "<A-k>",
          "<cmd>lua require('smart-splits').resize_down()<CR>",
          { noremap = true, silent = true }
        )
        vim.api.nvim_buf_set_keymap(
          term.bufnr,
          "t",
          "<A-l>",
          "<cmd>lua require('smart-splits').resize_right()<CR>",
          { noremap = true, silent = true }
        )
      end,
    },
    cmd = { "ToggleTerm", "TermExec" },
  },
}
