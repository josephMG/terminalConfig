return {
  "nvim-telescope/telescope.nvim",
  -- or                              , branch = '0.1.x',
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    pickers = {
      find_files = {
        mappings = {
          i = {
            ["<CR>"] = require("telescope.actions").select_tab,
          },
        },
      },
    },
  },
}
