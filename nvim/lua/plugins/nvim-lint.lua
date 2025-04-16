return {
  "mfussenegger/nvim-lint",
  -- enabled = false,
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint" },
      typescript = { "eslint" },
      javascriptreact = { "eslint" },
      typescriptreact = { "eslint" },
      svelte = { "eslint" },
      python = { "pylint" },
    }

    lint.linters.pylint.cmd = "python"
    lint.linters.pylint.args = { "-m", "pylint", "-f", "json" }
    -- lint.linters.pylint.args = { "-m", "pylint", "-f", "json", "--from-stdin", function() return vim.api.nvim_buf_get_name(0) end, }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>lt", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Force linting for current file" })
  end,
}
