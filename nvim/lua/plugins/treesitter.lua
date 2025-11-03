-- color syntax

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  -- enabled = false,
  dependencies = {
    "nvim-treesitter/playground",
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
      sync_install = false,
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
          init_selection = "gnn", -- set to `false` to disable one of the mappings
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
        keybindings = {
          toggle_query_editor = "o",
          toggle_hl_groups = "i",
          toggle_injected_languages = "t",
          toggle_anonymous_nodes = "a",
          toggle_language_display = "I",
          focus_language = "f",
          unfocus_language = "F",
          update = "R",
          goto_node = "<cr>",
          show_help = "?",
        },
      },
    })

    local wk = require("which-key")
    wk.add({
      {
        mode = "n",
        { "gn", group = "TreeSitter" }, -- group
        { "gnn", desc = "TreeSitter init selection" },
      },
      {
        mode = "v",
        { "gr", group = "TreeSitter Selection" }, -- group
        { "grn", desc = "TreeSitter node incremental" },
        { "grc", desc = "TreeSitter scope incremental" },
        { "grm", desc = "TreeSitter node decremental" },
      },
    })
  end,
}
