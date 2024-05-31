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
