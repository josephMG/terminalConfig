return {
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    lazy = false,
    -- enabled = false,
    opts = {
      flavour = "auto", -- latte, frappe, macchiato, mocha
      highlight_overrides = {
        all = function(colors)
          return {
            ["@tag.builtin"] = { fg = colors.mauve },
            NvimTreeNormal = { fg = colors.none },
            CmpBorder = { fg = "#3e4145" },
            CursorLineNr = { fg = colors.yellow },
            WinSeparator = { fg = colors.teal, style = { "bold" } },
          }
        end,
        mocha = function(colors)
          return {
            ["@tag.builtin"] = { fg = colors.mauve },
            ["@type.builtin"] = { fg = colors.yellow, style = { "italic" } or colors.styles.properties },
            -- ["@variable"] = { fg = colors.maroon, style = { "italic" } },
            ["@variable.member"] = { fg = colors.maroon, style = { "italic" } },
            Comment = { fg = colors.flamingo },
            LineNrAbove = { fg = colors.surface2 },
            LineNr = { fg = colors.blue },
            LineNrBelow = { fg = colors.surface2 },
            Visual = { bg = colors.surface2, style = { "bold" } },
          }
        end,
      },
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = false, -- disables setting the background color.
      float = {
        transparent = false, -- enable transparent floating windows
        solid = false, -- use solid styling for floating windows, see |winborder|
      },
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        types = { "italic" },
        variables = {},
        constants = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        numbers = {},
        booleans = {},
        properties = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
      },
      color_overrides = {},
      custom_highlights = {},
      default_integrations = true,
      auto_integrations = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
            ok = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
            ok = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
