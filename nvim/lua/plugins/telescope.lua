-- file search and grep

local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local select_one_or_multi = function(prompt_bufnr)
  local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()

  if vim.tbl_isempty(multi) then
    require("telescope.actions").select_default(prompt_bufnr)
    return
  end

  require("telescope.actions").close(prompt_bufnr)
  for _, entry in pairs(multi) do
    local filename = entry.filename or entry.value
    local lnum = entry.lnum or 1
    local lcol = entry.col or 1
    if filename then
      vim.cmd(string.format("edit %s", filename))
      -- vim.cmd(string.format("normal! %dG%d|", lnum, lcol))
    end
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    -- or                              , branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.52,
          },
          -- preview_cutoff = 120,
        },
        border = true,
        mappings = {
          i = {
            ["<CR>"] = select_one_or_multi,
            -- ["<CR>"] = require("telescope.actions").select_tab,
          },
          n = {
            ["<CR>"] = select_one_or_multi,
            -- ["<CR>"] = require("telescope.actions").select_tab,
          },
        },
      },
      extensions = {
        file_browser = {
          grouped = true,
          display_stat = false,
          layout_config = { height = 40, width = 180 },
          -- disables netrw and use telescope-file-browser in its place
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              -- your custom insert mode mappings
            },
            ["n"] = {
              -- your custom normal mode mappings
            },
          },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
