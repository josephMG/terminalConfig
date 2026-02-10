-- replace multiple tool
return {
  {
    "nvim-pack/nvim-spectre",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Spectre requires plenary.nvim
    config = function()
      -- Optional: Configure Spectre here if needed
      -- require("spectre").setup({
      --   -- Your custom settings
      -- })
    end,
    -- Define keymaps for Spectre
    keys = {
      {
        "<leader>S",
        function()
          require("spectre").toggle()
        end,
        desc = "Toggle Spectre",
      },
      {
        "<leader>sr",
        function()
          require("spectre").open_visual({ select_word = true })
        end,
        desc = "Search current word",
      },
      {
        "<leader>sR",
        function()
          require("spectre").open_file_search()
        end,
        desc = "Search in current file",
      },
    },
  },
  -- Other plugins...
}
