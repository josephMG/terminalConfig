-- keymaps are automatically loaded on the verylazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move block up 1 line" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move block down 2 lines" })

vim.keymap.set({ "n", "v", "i" }, "<S-C-l>", "<End>", { remap = true, desc = "Move to end of line" })
vim.keymap.set({ "n", "v", "i" }, "<S-C-h>", "<Home>", { remap = true, desc = "Move to start of line" })
-- vim.keymap.set({"n", "v", "i"}, "<C-Left>", "<Home>", { desc = "Move to end of line" })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<M-Left>", "<Cmd>BufferLineMovePrev<CR>")
vim.keymap.set("n", "<M-Right>", "<Cmd>BufferLineMoveNext<CR>")
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
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- black python formatting
vim.keymap.set("n", "<leader>fmp", ":silent !black %<cr>", { desc = "Python black formatting" })

local function close_buffer()
  local count_bufs_by_type = function(loaded_only)
    loaded_only = (loaded_only == nil and true or loaded_only)
    local count = { normal = 0, acwrite = 0, help = 0, nofile = 0, nowrite = 0, quickfix = 0, terminal = 0, prompt = 0 }
    local buftypes = vim.api.nvim_list_bufs()
    for _, bufname in pairs(buftypes) do
      if (not loaded_only) or vim.api.nvim_buf_is_loaded(bufname) then
        local buftype = vim.api.nvim_buf_get_option(bufname, "buftype")
        buftype = buftype ~= "" and buftype or "normal"
        count[buftype] = count[buftype] + 1
      end
    end
    return count
  end

  local bufTable = count_bufs_by_type()
  if bufTable.normal <= 1 then
    return vim.api.nvim_exec([[:q]], true)
  end
  return vim.api.nvim_exec([[:bd]], true)
end
vim.keymap.set({ "n", "i" }, "<C-s>", "<ESC>:w<CR>")
vim.keymap.set({ "n", "i" }, "<C-x>", close_buffer) -- close buffer or quit

vim.keymap.set(
  { "n" },
  "<C-M-Up>",
  "<cmd>resize -5<cr>",
  { silent = true, remap = true, desc = "Decrease Window Height" }
)
vim.keymap.set(
  { "n" },
  "<C-M-Down>",
  "<cmd>resize +5<cr>",
  { silent = true, remap = true, desc = "Increase Window Height" }
)
vim.keymap.set(
  { "n" },
  "<C-M-Left>",
  "<cmd>vertical resize -2<cr>",
  { silent = true, remap = true, desc = "Decrease Window Width" }
)
vim.keymap.set(
  { "n" },
  "<C-M-Right>",
  "<cmd>vertical resize +2<cr>",
  { silent = true, remap = true, desc = "Increase Window Width" }
)
