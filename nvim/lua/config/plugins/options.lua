function LineNumberColors()
  local colors = require("catppuccin.palettes").get_palette()
  vim.api.nvim_set_hl(0, "LineNrAbove", { fg = colors.surface1, bold = true })
  vim.api.nvim_set_hl(0, "LineNr", { fg = colors.pink, bold = true })
  vim.api.nvim_set_hl(0, "LineNrBelow", { fg = colors.surface1, bold = true })
end

-- catppuccin colorscheme
vim.cmd.colorscheme("catppuccin-mocha")

-- LineNumberColors()
