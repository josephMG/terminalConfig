-- color syntax
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  -- enabled = false,
  dependencies = {
    "windwp/nvim-ts-autotag",
  },
  main = "nvim-treesitter.config", -- Sets main module to use for opts
  opts = {
    ensure_installed = {
      "comment",
      "lua",
      "javascript",
      -- "javascriptreact",
      "jsdoc",
      "typescript",
      -- "typescriptreact",
      "tsx",
      "fish",
      "json",
      "yaml",
      "html",
      "css",
      "scss",
      "vue",
      "python",
      "markdown", -- lsp, lspsaga diagnostic
      "markdown_inline", -- lsp, lspsaga diagnostic
      "bash",
      "diff",
      "luadoc",
      "query",
      "vim",
      "vimdoc",
    },
    auto_install = true,
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "ruby" },
    },
    indent = { enable = true, disable = { "ruby" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn", -- set to `false` to disable one of the mappings
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  },
  config = function()
    -- import nvim-treesitter plugin

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

    -- ensure basic parser are installed
    local parsers = {
      "comment",
      "lua",
      "javascript",
      -- "javascriptreact",
      "jsdoc",
      "typescript",
      -- "typescriptreact",
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
    }
    require("nvim-treesitter").install(parsers)

    ---@param buf integer
    ---@param language string
    local function treesitter_try_attach(buf, language)
      -- check if parser exists and load it
      if not vim.treesitter.language.add(language) then
        return
      end
      -- enables syntax highlighting and other treesitter features
      vim.treesitter.start(buf, language)

      -- enables treesitter based folds
      -- for more info on folds see `:help folds`
      -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

      -- enables treesitter based indentation
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end

    local available_parsers = require("nvim-treesitter").get_available()
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf, filetype = args.buf, args.match
        local language = vim.treesitter.language.get_lang(filetype)
        if not language then
          return
        end

        local installed_parsers = require("nvim-treesitter").get_installed("parsers")

        if vim.tbl_contains(installed_parsers, language) then
          -- enable the parser if it is installed
          treesitter_try_attach(buf, language)
        elseif vim.tbl_contains(available_parsers, language) then
          -- if a parser is available in `nvim-treesitter` enable it after ensuring it is installed
          require("nvim-treesitter").install(language):await(function()
            treesitter_try_attach(buf, language)
          end)
        else
          -- try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
          treesitter_try_attach(buf, language)
        end
      end,
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
