return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    opts = {
      -- Set debug logging
      log_level = "DEBUG",
    },
    adapters = {
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          env = {
            url = "http://host.docker.internal:11434",
          },
          parameters = {
            sync = true,
          },
          schema = {
            model = {
              -- default = "qwen3:4b",
              default = "gemma3:4b",
            },
            num_ctx = {
              default = 16384,
            },
            num_predict = {
              default = -1,
            },
          },
        })
      end,
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "GEMINI_API_KEY",
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
      agent = {
        adapter = "gemini",
      },
    },
  },
  config = function(_, opts)
    extend_opts = {
      display = {
        chat = {
          window = {
            layout = "vertical", -- float|vertical|horizontal|buffer
            position = "right",
            -- border = "double", -- float only
          },
          show_settings = true,
        },
        diff = {
          enabled = true,
          close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
          layout = "vertical", -- vertical|horizontal split for default provider
          opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
          provider = "default", -- default|mini_diff
        },
        action_palette = {
          width = 95,
          height = 10,
          prompt = "Prompt ", -- Prompt used for interactive LLM calls
          provider = "default", -- Can be "default", "telescope", or "mini_pick". If not specified, the plugin will autodetect installed providers.
          opts = {
            show_default_actions = true, -- Show the default actions in the action palette?
            show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          },
        },
        inline = {
          layout = "vertical", -- vertical|horizontal|buffer
        },
      },
    }

    merged_opts = vim.tbl_deep_extend("force", opts, extend_opts)
    require("codecompanion").setup(merged_opts)
  end,
}
