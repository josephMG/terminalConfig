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
      vim.cmd(string.format("tabnew +%d %s", lnum, filename))
      vim.cmd(string.format("normal! %dG%d|", lnum, lcol))
    end
  end
end

return {
  "nvim-telescope/telescope.nvim",
  -- or                              , branch = '0.1.x',
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    defaults = {
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
  },
}
