-- buffer line on top of nvim

_G.__cached_neo_tree_selector = nil
_G.__get_selector = function()
  return _G.__cached_neo_tree_selector
end

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    -- mode = "tabs",
    options = {
      sort_by = "insert_after_current",
      numbers = function(opts)
        local state = require("bufferline.state")
        for i, buf in ipairs(state.components) do
          if buf.id == opts.id then
            return i
          end
        end
        return opts.ordinal
      end,
      offsets = {
        {
          filetype = "neo-tree",
          raw = " %{%v:lua.__get_selector()%} ",
          highlight = { sep = { link = "WinSeparator" } },
          separator = "┃",
        },
      },
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " " or (e == "warning" and " " or " ")
          s = s .. n .. sym
        end
        return s
      end,
    },
  },
  config = function(_, opts)
    vim.opt.termguicolors = true
    require("bufferline").setup(opts)
    -- vim.api.nvim_create_autocmd("BufAdd", {
    --   callback = function()
    --     require("bufferline").sort_by(function(buf_a, buf_b)
    --       return buf_a.id < buf_b.id
    --     end)
    --   end,
    -- })
  end,
}
