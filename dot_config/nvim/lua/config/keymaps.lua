-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

local lazyterm = function()
  Util.terminal(nil, { cwd = Util.root() })
end

-- remove default keymaps
vim.keymap.del({ "n", "t" }, "<c-_>")

vim.keymap.set("n", "<c-\\>", lazyterm, { desc = "Terminal (root dir)" })
vim.keymap.set("t", "<c-\\>", "<cmd>close<cr>", { desc = "Hide Terminal" })

vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>w-")
vim.keymap.set("n", "<leader>\\", "<C-W>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>w\\", "<C-W>s", { desc = "Split window below" })
