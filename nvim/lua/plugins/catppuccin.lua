return {
  "catppuccin/nvim",
  name = "catppuccin",
  opts = {
    flavour = "mocha",
    highlight_overrides = {
      all = function(colors)
        return {
          NvimTreeNormal = { fg = colors.none },
          CmpBorder = { fg = "#3e4145" },
          CursorLineNr = { fg = colors.yellow },
        }
      end,
      mocha = function(mocha)
        return {
          Comment = { fg = mocha.flamingo },
          LineNrAbove = { fg = mocha.surface2 },
          LineNr = { fg = mocha.blue },
          LineNrBelow = { fg = mocha.surface2 },
          Visual = { bg = mocha.surface2, style = { "bold" } },
        }
      end,
    },
  },
}
