return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  config = function()
    -- import nvim-treesitter plugin
    local treesitter = require("nvim-treesitter.configs")

    require("nvim-ts-autotag").setup({
      enable = true,
      filetypes = {

        "html",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "xml",
      },
    })

    -- configure treesitter
    treesitter.setup({ -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },

      -- ensure these language parsers are installed
      ensure_installed = {
        "comment",
        "lua",
        "javascript",
        "jsdoc",
        "typescript",
        "tsx",
        "fish",
        "json",
        "yaml",
        "html",
        "css",
        "scss",
        "vue",
        "svelte",
        "markdown", -- lsp, lspsaga diagnostic
        "markdown_inline", -- lsp, lspsaga diagnostic
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
