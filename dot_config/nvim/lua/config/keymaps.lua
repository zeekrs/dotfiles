-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keys = require("config.keys")

-- remove default keymaps
vim.keymap.del({ "n", "t" }, "<C-_>")
vim.keymap.del({ "n", "t" }, "<C-/>")
vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>")
-- vim.keymap.del("n", "<leader>gG")

vim.keymap.set({ "n", "t" }, "<C-\\>", function()
  Snacks.terminal(nil, { cwd = LazyVim.root() })
end, { desc = "which_key_ignore" })

vim.keymap.set({ "n", "t" }, keys["<C-=>"], function()
  Snacks.terminal(nil, { win = { position = "float" } })
end, { desc = "which_key_ignore" })
-- yazi
vim.keymap.set({ "n", "t" }, "<leader>Z", function()
  Snacks.terminal("yazi", { cwd = LazyVim.root() })
end, { desc = "Toggle Yazi" })

-- reset split window
vim.keymap.del("n", "<leader>-")
vim.keymap.set("n", "<leader>\\", "<C-W>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>w\\", "<C-W>s", { desc = "Split window below" })
--
vim.keymap.set({ "i", "x", "n", "s" }, keys["<CMD-s>"], "<cmd>w<cr><esc>", { desc = "Save file" })

-- hack keys
vim.keymap.set({ "i", "x", "n", "s" }, keys["<C-i>"], "<C-i>")

vim.keymap.set({ "i", "x", "s" }, keys["<C-=>"], "<C-=>")

vim.keymap.set({ "i", "x", "n", "s" }, keys["<C-m>"], "<C-m>")

-- insert mode emacs like editing
vim.keymap.set("i", "<C-a>", "<Home>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-e>", "<End>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-f>", "<Right>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-b>", "<Left>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-p>", "<Up>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-n>", "<Down>", { noremap = true, silent = false })

-- command mode emacs like editing
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true, silent = false })
vim.keymap.set("c", "<C-e>", "<End>", { noremap = true, silent = false })
vim.keymap.set("c", "<C-f>", "<Right>", { noremap = true, silent = false })
vim.keymap.set("c", "<C-b>", "<Left>", { noremap = true, silent = false })
