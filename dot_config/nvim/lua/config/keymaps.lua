-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keys = require("config.keys")

-- terminals
local Terminal = require("toggleterm.terminal").Terminal

local f_termianl = Terminal:new({
  display_name = "flaot terminal",
  direction = "float",
  dir = "git_dir",
  id = 99,
})

local function _f_terminal_toggle()
  f_termianl:toggle()
end

local lazygit_terminal = Terminal:new({
  display_name = "lazygit",
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  id = 999,
  on_open = function(term)
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  end,
})

local function _lazygit_terminal_toggle()
  lazygit_terminal:toggle()
end

-- remove default keymaps
vim.keymap.del({ "n", "t" }, "<C-_>")
vim.keymap.del({ "n", "t" }, "<C-/>")
vim.keymap.del({ "t" }, "<C-h>")
vim.keymap.del({ "t" }, "<C-j>")
vim.keymap.del({ "t" }, "<C-k>")
vim.keymap.del({ "t" }, "<C-l>")
vim.keymap.del({ "i", "x", "n", "s" }, "<C-s>")
vim.keymap.del("n", "<leader>gG")

vim.keymap.set({ "n", "t" }, "<C-\\>", "<cmd>execute v:count1 . 'ToggleTerm'<CR>", { desc = "Toggle Float Terminal" })

vim.keymap.set({ "n", "t" }, keys["<C-=>"], _f_terminal_toggle, { desc = "Toggle Float Terminal" })
--
vim.keymap.set({ "n", "t" }, "<leader>gg", _lazygit_terminal_toggle, { desc = "Toggle Lazy Git" })

vim.keymap.set({ "t" }, "<esc><esc>", "<cmd>close<CR>", { desc = "Close Terminal" })

-- reset split window
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>w-")
vim.keymap.set("n", "<leader>\\", "<C-W>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>w\\", "<C-W>s", { desc = "Split window below" })

vim.keymap.set({ "i", "x", "n", "s" }, keys["<CMD-s>"], "<cmd>w<cr><esc>", { desc = "Save file" })

-- insert mode emacs like editing
vim.keymap.set("i", "<C-a>", "<Home>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-e>", "<End>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-f>", "<Right>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-b>", "<Left>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-p>", "<Up>", { noremap = true, silent = false })
vim.keymap.set("i", "<C-n>", "<Down>", { noremap = true, silent = false })
