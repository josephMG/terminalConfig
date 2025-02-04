-- telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- neo-tree
vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle filesystem left<cr>", { desc = "Explorer NeoTree (cwd)" })
vim.keymap.set("n", "<leader>e", "<leader>fe", { desc = "Explorer NeoTree (cwd)" })
vim.keymap.set("n", "<leader>ge", "<cmd>Neotree toggle git_status left<cr>", { desc = "Git Explorer" })
vim.keymap.set("n", "<leader>be", "<cmd>Neotree toggle buffers left<cr>", { desc = "Buffer Explorer" })

-- MarkdownPreview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>", { desc = "Markdown preview" })

-- nvim-comment
vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)<cr>")
vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)<cr>")

-- lsp-zero
vim.keymap.set("n", "<leader>fmd", vim.lsp.buf.format)

-- bufferline
