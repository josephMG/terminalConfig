local SymbolKind = vim.lsp.protocol.SymbolKind
return {
  "VidocqH/lsp-lens.nvim",
  enabled = true,
  opts = {
    include_declaration = true, -- Reference include declaration
    sections = {
      definition = function(count)
        return "󰳽 Definitions: " .. count
      end,
      references = function(count)
        return "󰌹 References: " .. count
      end,
      implements = function(count)
        return "󰡱 Implements: " .. count
      end,
      git_authors = function(latest_author, count)
        return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
      end,
    },
    ignore_filetype = {
      "prisma",
    },
    -- Target Symbol Kinds to show lens information
    target_symbol_kinds = {
      SymbolKind.Function,
      SymbolKind.Method,
      SymbolKind.Interface,
      SymbolKind.Constant,
      SymbolKind.Enum,
    },
    -- Symbol Kinds that may have target symbol kinds as children
    wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
  },
  config = function(_, opts)
    require("lsp-lens").setup(opts)
  end,
}
