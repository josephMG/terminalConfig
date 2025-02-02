-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<S-C-Right>", "<End>", { remap = true, desc = "Move to end of line" })
vim.keymap.set("n", "<S-C-Left>", "<Home>", { remap = true, desc = "Move to start of line" })
-- vim.keymap.set({"n", "v", "i"}, "<C-Left>", "<Home>", { desc = "Move to end of line" })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
vim.keymap.set("n", "<leader>bx", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })


-- yank to clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- black python formatting
vim.keymap.set("n", "<leader>fmp", ":silent !black %<cr>", { desc = "Python black formatting" })
