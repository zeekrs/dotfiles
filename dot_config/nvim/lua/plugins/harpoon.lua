local prefix = "<leader><space>"
local term_string = vim.fn.exists("$TMUX") == 1 and "tmux" or "terminal"
local maps = { n = {} }
local icon = vim.g.icons_enabled and "󱡀 " or ""
maps.n[prefix] = { desc = icon .. "Harpoon" }

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
    keys = {
      {
        prefix .. "a",
        function()
          require("harpoon"):list():append()
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
    },
  },
}
