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

-- -- symbol-usage
-- return {
--   enabled = false,
--   "Wansmer/symbol-usage.nvim",
--   event = "BufReadPre", -- need run before LspAttach if you use nvim 0.9. On 0.10 use 'LspAttach'
--   config = function()
--     local function h(name)
--       return vim.api.nvim_get_hl(0, { name = name })
--     end
--
--     -- hl-groups can have any name
--     vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
--     vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
--     vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
--     vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
--     vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })
--
--     local function text_format(symbol)
--       local res = {}
--
--       local round_start = { "", "SymbolUsageRounding" }
--       local round_end = { "", "SymbolUsageRounding" }
--
--       -- Indicator that shows if there are any other symbols in the same line
--       local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""
--
--       if symbol.references then
--         local usage = symbol.references <= 1 and "usage" or "usages"
--         local num = symbol.references == 0 and "no" or symbol.references
--         table.insert(res, round_start)
--         table.insert(res, { "󰌹 ", "SymbolUsageRef" })
--         table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
--         table.insert(res, round_end)
--       end
--
--       if symbol.definition then
--         if #res > 0 then
--           table.insert(res, { " ", "NonText" })
--         end
--         table.insert(res, round_start)
--         table.insert(res, { "󰳽 ", "SymbolUsageDef" })
--         table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
--         table.insert(res, round_end)
--       end
--
--       if symbol.implementation then
--         if #res > 0 then
--           table.insert(res, { " ", "NonText" })
--         end
--         table.insert(res, round_start)
--         table.insert(res, { "󰡱 ", "SymbolUsageImpl" })
--         table.insert(res, { symbol.implementation .. " impls", "SymbolUsageContent" })
--         table.insert(res, round_end)
--       end
--
--       if stacked_functions_content ~= "" then
--         if #res > 0 then
--           table.insert(res, { " ", "NonText" })
--         end
--         table.insert(res, round_start)
--         table.insert(res, { " ", "SymbolUsageImpl" })
--         table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
--         table.insert(res, round_end)
--       end
--
--       return res
--     end
--
--     local filter_js_vars = {
--       function(data)
--         local symbol, _, bufnr = data.symbol, data.parent, data.bufnr
--         if not vim.api.nvim_buf_is_loaded(bufnr) then
--           return
--         end
--         if is_ts(bufnr) then
--           local pos = { symbol.range.start.line, symbol.range.start.character }
--           -- Treesitter may still lose buffer context
--           local ok, node = pcall(vim.treesitter.get_node, { bufrn = bufnr, pos = pos })
--           if (ok and node) and node:type() == "identifier" and node:parent():type() == "variable_declarator" then
--             local value = node:parent():field("value")[1]
--             return vim.tbl_contains({ "arrow_function", "function" }, value and value:type() or "")
--           end
--           return false
--         else
--           -- Fallback to check if treesitter is not attached
--           local ln = symbol.range.start.line
--           local text = vim.api.nvim_buf_get_lines(bufnr, ln, ln + 1, true)[1] or ""
--           return text:find("function") or text:find("=>")
--         end
--       end,
--     }
--
--     local SymbolKind = vim.lsp.protocol.SymbolKind
--
--     require("symbol-usage").setup({
--       text_format = text_format,
--       kinds = {
--         SymbolKind.File,
--         SymbolKind.Module,
--         SymbolKind.Namespace,
--         SymbolKind.Package,
--         SymbolKind.Class,
--         SymbolKind.Method,
--         SymbolKind.Property,
--         SymbolKind.Field,
--         SymbolKind.Constructor,
--         SymbolKind.Enum,
--         SymbolKind.Interface,
--         SymbolKind.Function,
--         SymbolKind.Variable,
--         SymbolKind.Constant,
--         SymbolKind.String,
--         SymbolKind.Number,
--         SymbolKind.Boolean,
--         SymbolKind.Array,
--         SymbolKind.Object,
--         SymbolKind.Key,
--         SymbolKind.Null,
--         SymbolKind.EnumMember,
--         SymbolKind.Struct,
--         SymbolKind.Event,
--         SymbolKind.Operator,
--         SymbolKind.TypeParameter,
--       },
--       kinds_filter = {
--         [SymbolKind.Variable] = filter_js_vars,
--         [SymbolKind.Constant] = filter_js_vars,
--         [SymbolKind.Function] = {
--           function(data)
--             -- If an anonymous function has been passed as an argument, its name contains `() callback` in it
--             if data.symbol.name:find("() callback") then
--               return false
--             end
--             return true
--           end,
--         },
--       },
--       references = { enabled = true, include_declaration = true },
--       definition = { enabled = true },
--       implementation = { enabled = true },
--       symbol_request_pos = "start",
--     })
--   end,
-- }
