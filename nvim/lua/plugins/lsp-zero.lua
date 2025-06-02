return {

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
    },
    opts = {
      -- make sure mason installs the server
      servers = {
        pyright = {},
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { "vim" },
            },
          },
        },
        --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
        --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
        tsserver = {
          enabled = false,
        },
        ts_ls = {
          enabled = true,
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          settings = {
            suggest = {
              completeFunctionCalls = true,
            },
            typescript = {
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true, showOnAllFunctions = true },
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
            javascript = {
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true, showOnAllFunctions = true },
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
          keys = {
            {
              "gD",
              function()
                local params = vim.lsp.util.make_position_params()
                vim.lsp.execute({
                  command = "typescript.goToSourceDefinition",
                  arguments = { params.textDocument.uri, params.position },
                  open = true,
                })
              end,
              desc = "Goto Source Definition",
            },
            {
              "gR",
              function()
                vim.lsp.execute({
                  command = "typescript.findAllFileReferences",
                  arguments = { vim.uri_from_bufnr(0) },
                  open = true,
                })
              end,
              desc = "File References",
            },
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({ source = { organizeImports = true } })
              end,
              desc = "Organize Imports",
            },
            {
              "<leader>cM",
              function()
                vim.lsp.buf.code_action({ source = { addMissingImports = { ts = true } } })
              end,
              desc = "Add missing imports",
            },
            {
              "<leader>cu",
              function()
                vim.lsp.buf.code_action({ source = { removeUnused = { ts = true } } })
              end,
              desc = "Remove unused imports",
            },
            {
              "<leader>cD",
              function()
                vim.lsp.buf.code_action({ source = { fixAll = { ts = true } } })
              end,
              desc = "Fix all diagnostics",
            },
            {
              "<leader>cV",
              function()
                vim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
              end,
              desc = "Select TS workspace version",
            },
          },
        },
      },
      setup = {
        --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
        --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
        tsserver = function()
          -- disable tsserver
          return true
        end,
        ts_ls = function(_, opts)
          -- copy typescript settings to javascript
          opts.settings.javascript =
            vim.tbl_deep_extend("force", {}, opts.settings.typescript, opts.settings.javascript or {})
        end,
      },
    },
    init = function()
      -- Reserve a space in the gutter
      -- This will avoid an annoying layout shift in the screen
      vim.opt.signcolumn = "yes"
    end,
    config = function(_, opts)
      local lsp_defaults = require("lspconfig").util.default_config
      local mason_lspconfig = require("mason-lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")

      -- Set which codelens text levels to show
      local original_set_virtual_text = vim.lsp.diagnostic.set_virtual_text
      local set_virtual_text_custom = function(diagnostics, bufnr, client_id, sign_ns, opts)
        opts = opts or {}
        -- show all messages that are Warning and above (Warning, Error)
        opts.severity_limit = "Warning"
        original_set_virtual_text(diagnostics, bufnr, client_id, sign_ns, opts)
      end

      vim.lsp.diagnostic.set_virtual_text = set_virtual_text_custom
      local orig_set_signs = vim.lsp.diagnostic.set_signs
      local set_signs_limited = function(diagnostics, bufnr, client_id, sign_ns, opts)
        opts = opts or {}
        opts.severity_limit = "Error"
        orig_set_signs(diagnostics, bufnr, client_id, sign_ns, opts)
      end

      vim.lsp.diagnostic.set_signs = set_signs_limited

      -- LspAttach is where you enable features that only work
      -- if there is a language server active in the file
      local function on_attach(ev)
        local keymap = vim.keymap
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }
        -- set keybinds
        keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

        opts.desc = "Show LSP references"
        keymap.set("n", "gR", vim.lsp.buf.references, opts)

        opts.desc = "Show LSP references (Telescope)"
        keymap.set(
          "n",
          "gr",
          -- "<cmd>lua require('telescope.builtin').lsp_references({ jump_type = 'tab', reuse_win = true })<CR>",
          "<cmd>lua require('telescope.builtin').lsp_references({ reuse_win = true })<CR>",
          opts
        ) -- show definition, references

        opts.desc = "Go to declaration"
        keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Show LSP definitions"
        -- keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        keymap.set(
          "n",
          "gd",
          -- "<cmd>lua require('telescope.builtin').lsp_definitions({ jump_type = 'tab', reuse_win = true })<CR>",
          "<cmd>lua require('telescope.builtin').lsp_definitions({ reuse_win = true })<CR>",
          opts
        ) -- show lsp definitions

        opts.desc = "Show LSP implementations"
        -- keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        keymap.set(
          "n",
          "gi",
          -- "<cmd>lua require('telescope.builtin').lsp_implementations({ jump_type = 'tab', reuse_win = true })<CR>",
          "<cmd>lua require('telescope.builtin').lsp_implementations({ reuse_win = true })<CR>",
          opts
        ) -- show lsp implementations

        opts.desc = "Show LSP type definitions"
        -- keymap.set("n", "gt", vim.lsp.buf.type_definition, opts) -- show lsp type definitions
        keymap.set(
          "n",
          "gt",
          -- "<cmd>lua require('telescope.builtin').lsp_type_definitions({ jump_type = 'tab', reuse_win = true })<CR>",
          "<cmd>lua require('telescope.builtin').lsp_type_definitions({ reuse_win = true })<CR>",
          opts
        ) -- show lsp type definitions

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = "Show buffer diagnostics"
        keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = "Restart LSP"
        keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor
      end

      -- used to enable autocompletion (assign to every lsp server config)
      local capabilities = cmp_nvim_lsp.default_capabilities()

      -- Change the Diagnostic symbols in the sign column (gutter)
      -- (not in youtube nvim video)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      vim.cmd([[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]])
      vim.cmd([[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]])

      local border = {
        { "🭽", "FloatBorder" },
        { "▔", "FloatBorder" },
        { "🭾", "FloatBorder" },
        { "▕", "FloatBorder" },
        { "🭿", "FloatBorder" },
        { "▁", "FloatBorder" },
        { "🭼", "FloatBorder" },
        { "▏", "FloatBorder" },
      }

      -- LSP settings (for overriding per client)
      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
      }

      -- local function organize_imports()
      --   local params = {
      --     command = "_typescript.organizeImports",
      --     arguments = { vim.api.nvim_buf_get_name(0) },
      --     title = "",
      --   }
      --   vim.lsp.buf.execute_command(params)
      -- end
      -- local function remove_unused_imports()
      --   vim.lsp.buf.code_action({
      --     apply = true,
      --     context = {
      --       only = { "source.removeUnusedImports.ts" },
      --       diagnostics = {},
      --     },
      --   })
      -- end

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
        handlers = handlers,
        on_attach = on_attach,
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        settings = opts.servers.ts_ls.settings,

        -- commands = {
        --   OrganizeImports = {
        --     organize_imports,
        --     description = "Organize Imports",
        --   },
        --   RemoveUnusedImports = {
        --     remove_unused_imports,
        --     description = "Remove Unused Imports",
        --   },
        -- },
      })
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        handlers = handlers,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
    end,
  },

  -- Mason
  {

    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    lazy = false,
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts_extend = { "ensure_installed" },
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {
        "stylua",
        "shfmt",
        "prettier",
      }
      table.insert(opts.ensure_installed, "js-debug-adapter")
    end,
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
      require("mason").setup(opts)
      local mason_tool_installer = require("mason-tool-installer")
      local mason_lspconfig = require("mason-lspconfig")
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function()
          -- trigger FileType event to possibly load this newly installed LSP server
          require("lazy.core.handler.event").trigger({
            event = "FileType",
            buf = vim.api.nvim_get_current_buf(),
          })
        end, 100)
      end)

      mr.refresh(function()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end)
      -- import mason-lspconfig
      mason_lspconfig.setup({
        -- list of servers for mason to install
        -- ensure_installed = {
        -- },
        -- auto-install configured servers (with lspconfig)
        -- automatic_installation = true, -- not the same as ensure_installed
      })

      mason_tool_installer.setup({
        ensure_installed = {
          -- lsp
          "ts_ls",
          "html",
          "cssls",
          "tailwindcss",
          "lua_ls",
          "emmet_language_server",
          "pyright",

          -- formatter
          "prettier", -- prettier formatter
          "stylua", -- lua formatter
          "isort", -- python formatter
          "black", -- python formatter
          "pylint", -- python linter
          "eslint", -- js linter
        },
      })
    end,
  },

  -- Autocompletion
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
}
