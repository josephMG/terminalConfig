return {
  "folke/trouble.nvim",
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = "Trouble",
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xcs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xcl",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions / references / ... (Trouble)",
    },
    {
      "<leader>xL",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xQ",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
  config = function()
    local wk = require("which-key")
    wk.add({
      {
        -- { "<leader>x", group = "Trouble" }, -- group
        { "<leader>xx", desc = "Diagnostics (Trouble)" },
        { "<leader>xX", desc = "Buffer Diagnostics (Trouble)" },
        { "<leader>xcs", desc = "Symbols (Trouble)" },
        { "<leader>xcl", desc = "LSP Definitions / references / ... (Trouble)" },
        { "<leader>xL", desc = "Location List (Trouble)" },
        { "<leader>xQ", desc = "Quickfix List (Trouble)" },
      },
    })
  end,
}
