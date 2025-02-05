return {
  "nvim-telescope/telescope.nvim",
  -- or                              , branch = '0.1.x',
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- defaults = {
    --   mappings = {
    --     i = {
    --       ["<CR>"] = require("telescope.actions").select_tab,
    --     },
    --     n = {
    --       ["<CR>"] = require("telescope.actions").select_tab,
    --     },
    --   },
    -- },
  },
}
