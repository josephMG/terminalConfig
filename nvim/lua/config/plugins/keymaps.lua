-- telescope

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
vim.keymap.set("n", "<leader>fw", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, { desc = "Telescope grep string" })
vim.keymap.set("n", "<leader>fr", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
-- vim.keymap.set("n", "<leader>fr", function()
--   require("telescope").extensions.file_browser.file_browser({
--     respect_gitignore = false,
--     group = true,
--     grouped = true,
--     display_stat = { date = true, size = false, mode = false },
--     hijack_netrw = true,
--     layout_config = { height = 40, width = 180 },
--   })
-- end)

-- neo-tree
vim.keymap.set("n", "<leader>fe", "<cmd>Neotree toggle filesystem left<cr>", { desc = "Explorer NeoTree (cwd)" })
vim.keymap.set("n", "<leader>ge", "<cmd>Neotree toggle git_status left<cr>", { desc = "Git Explorer" })
vim.keymap.set("n", "<leader>be", "<cmd>Neotree toggle buffers left<cr>", { desc = "Buffer Explorer" })

-- MarkdownPreview
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<cr>", { desc = "Markdown preview" })

-- nvim-comment
vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)<cr>")
vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)<cr>")

-- lsp-zero
vim.keymap.set("n", "<leader>fmd", vim.lsp.buf.format)

-- bufferline
--

-- avante
-- prefil edit window with common scenarios to avoid repeating query and submit immediately
local prefill_edit_window = function(request)
  require("avante.api").edit()
  local code_bufnr = vim.api.nvim_get_current_buf()
  local code_winid = vim.api.nvim_get_current_win()
  if code_bufnr == nil or code_winid == nil then
    return
  end
  vim.api.nvim_buf_set_lines(code_bufnr, 0, -1, false, { request })
  -- Optionally set the cursor position to the end of the input
  vim.api.nvim_win_set_cursor(code_winid, { 1, #request + 1 })
  -- Simulate Ctrl+S keypress to submit
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-s>", true, true, true), "v", true)
end

-- NOTE: most templates are inspired from ChatGPT.nvim -> chatgpt-actions.json
local avante_grammar_correction = "Correct the text to standard English, but keep any code blocks inside intact."
local avante_keywords = "Extract the main keywords from the following text"
local avante_code_readability_analysis = [[
  You must identify any readability issues in the code snippet.
  Some readability issues to consider:
  - Unclear naming
  - Unclear purpose
  - Redundant or obvious comments
  - Lack of comments
  - Long or complex one liners
  - Too much nesting
  - Long variable names
  - Inconsistent naming and code style.
  - Code repetition
  You may identify additional problems. The user submits a small section of code from a larger file.
  Only list lines with readability issues, in the format <line_num>|<issue and proposed solution>
  If there's no issues with code respond with only: <OK>
]]
local avante_optimize_code = "Optimize the following code"
local avante_summarize = "Summarize the following text"
local avante_translate = "Translate this into English, but keep any code blocks inside intact"
local avante_explain_code = "Explain the following code"
local avante_complete_code = "Complete the following codes written in " .. vim.bo.filetype
local avante_add_docstring = "Add docstring to the following codes"
local avante_fix_bugs = "Fix the bugs inside the following codes if any"
local avante_add_tests = "Implement tests for the following code"

require("which-key").add({
  { "<leader>a", group = "Avante" }, -- NOTE: add for avante.nvim
  {
    mode = { "n", "v" },
    {
      "<leader>ag",
      function()
        require("avante.api").ask({ question = avante_grammar_correction })
      end,
      desc = "Grammar Correction(ask)",
    },
    {
      "<leader>ak",
      function()
        require("avante.api").ask({ question = avante_keywords })
      end,
      desc = "Keywords(ask)",
    },
    {
      "<leader>al",
      function()
        require("avante.api").ask({ question = avante_code_readability_analysis })
      end,
      desc = "Code Readability Analysis(ask)",
    },
    {
      "<leader>ao",
      function()
        require("avante.api").ask({ question = avante_optimize_code })
      end,
      desc = "Optimize Code(ask)",
    },
    {
      "<leader>am",
      function()
        require("avante.api").ask({ question = avante_summarize })
      end,
      desc = "Summarize text(ask)",
    },
    {
      "<leader>an",
      function()
        require("avante.api").ask({ question = avante_translate })
      end,
      desc = "Translate text(ask)",
    },
    {
      "<leader>ax",
      function()
        require("avante.api").ask({ question = avante_explain_code })
      end,
      desc = "Explain Code(ask)",
    },
    {
      "<leader>ac",
      function()
        require("avante.api").ask({ question = avante_complete_code })
      end,
      desc = "Complete Code(ask)",
    },
    {
      "<leader>ad",
      function()
        require("avante.api").ask({ question = avante_add_docstring })
      end,
      desc = "Docstring(ask)",
    },
    {
      "<leader>ab",
      function()
        require("avante.api").ask({ question = avante_fix_bugs })
      end,
      desc = "Fix Bugs(ask)",
    },
    {
      "<leader>au",
      function()
        require("avante.api").ask({ question = avante_add_tests })
      end,
      desc = "Add Tests(ask)",
    },
  },
})

require("which-key").add({
  { "<leader>a", group = "Avante" }, -- NOTE: add for avante.nvim
  {
    mode = { "v" },
    {
      "<leader>aG",
      function()
        prefill_edit_window(avante_grammar_correction)
      end,
      desc = "Grammar Correction",
    },
    {
      "<leader>aK",
      function()
        prefill_edit_window(avante_keywords)
      end,
      desc = "Keywords",
    },
    {
      "<leader>aO",
      function()
        prefill_edit_window(avante_optimize_code)
      end,
      desc = "Optimize Code(edit)",
    },
    {
      "<leader>aC",
      function()
        prefill_edit_window(avante_complete_code)
      end,
      desc = "Complete Code(edit)",
    },
    {
      "<leader>aD",
      function()
        prefill_edit_window(avante_add_docstring)
      end,
      desc = "Docstring(edit)",
    },
    {
      "<leader>aB",
      function()
        prefill_edit_window(avante_fix_bugs)
      end,
      desc = "Fix Bugs(edit)",
    },
    {
      "<leader>aU",
      function()
        prefill_edit_window(avante_add_tests)
      end,
      desc = "Add Tests(edit)",
    },
  },
})
