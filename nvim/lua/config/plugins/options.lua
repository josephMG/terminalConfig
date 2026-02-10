function CustomizeColor()
  local colors = require("catppuccin.palettes").get_palette()
  -- vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.surface1, bold = true })
  -- vim.api.nvim_set_hl(0, "LineNr", { fg = colors.pink, bold = true })
  -- vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.surface1, bold = true })
  vim.api.nvim_set_hl(0, "Search", { bg = colors.maroon, fg = colors.surface1 })
  vim.api.nvim_set_hl(0, "GitsignsCurrentLineBlame", { fg = colors.overlay1 })
end

-- catppuccin colorscheme
vim.cmd([[colorscheme catppuccin]])
CustomizeColor()

-- vim.cmd([[colorscheme tokyonight-night]])
--
require("telescope").load_extension("file_browser")
