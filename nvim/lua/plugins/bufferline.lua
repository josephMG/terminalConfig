return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  opts = {
    -- mode = "tabs",
    options = {
      sort_by = "insert_at_end",
      numbers = "both",
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
