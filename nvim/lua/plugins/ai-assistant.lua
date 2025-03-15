return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    opts = {
      debug = true,
      behaviour = {
        enable_cursor_planning_mode = true,
      },
      -- provider = "groq",
      -- cursor_applying_provider = "groq",
      -- vendors = {
      --   groq = {
      --     __inherited_from = "openai",
      --     api_key_name = "GROQ_API_KEY",
      --     endpoint = "https://api.groq.com/openai/v1/",
      --     model = "gemma2-9b-it",
      --     max_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
      --   },
      -- },
      -- vendors = {
      --   groq = {
      --     __inherited_from = "openai",
      --     api_key_name = "GROQ_API_KEY",
      --     endpoint = "https://api.groq.com/openai/v1/",
      --     model = "deepseek-r1-distill-llama-70b",
      --   },
      -- },
      provider = "ollama",
      ollama = {
        -- endpoint = "http://127.0.0.1:11434",
        endpoint = "http://host.docker.internal:11434",
        model = "deepseek-r1:8b",
        disable_tools = true,
        -- parse_curl_args = function(opts, code_opts)
        --   return {
        --     url = opts.endpoint .. "/chat",
        --     headers = {
        --       ["Accept"] = "application/json",
        --       ["Content-Type"] = "application/json",
        --     },
        --     body = {
        --       model = opts.model,
        --       options = {
        --         num_ctx = 16384,
        --       },
        --       messages = require("avante.providers").copilot.parse_messages(code_opts), -- you can make your own message, but this is very advanced
        --       stream = true,
        --     },
        --   }
        -- end,
        -- parse_stream_data = function(data, handler_opts)
        --   -- Parse the JSON data
        --   local json_data = vim.fn.json_decode(data)
        --   -- Check for stream completion marker first
        --   if json_data and json_data.done then
        --     -- handler_opts.on_complete(nil) -- Properly terminate the stream
        --     handler_opts.on_stop({ reason = json_data.done_reason or "stop" })
        --     return
        --   end
        --   -- Process normal message content
        --   if json_data and json_data.message and json_data.message.content then
        --     -- Extract the content from the message
        --     local content = json_data.message.content
        --     -- Call the handler with the content
        --     handler_opts.on_chunk(content)
        --   end
        -- end,
      },
    },
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
    "robitx/gp.nvim",
    config = function()
      local conf = {
        providers = {
          openai = {
            disable = true,
            endpoint = "https://api.openai.com/v1/chat/completions",
            -- secret = os.getenv("OPENAI_API_KEY"),
          },
          ollama = {
            endpoint = "http://localhost:11434/v1/chat/completions",
          },
        },
        agents = {
          {
            provider = "ollama",
            name = "OllamaDeepSeek",
            chat = true,
            command = true,
            model = {
              model = "deepseek-r1:8b",
              temperature = 0.6,
              top_p = 1,
              min_p = 0.05,
            },
            system_prompt = "You are a general AI assistant.",
          },
          {
            name = "CodeOllamaLlama3.1-8B", -- standard agent name to disable
            disable = true,
          },
          {
            name = "ChatOllamaLlama3.1-8B", -- standard agent name to disable
            disable = true,
          },
        },
      }
      require("gp").setup(conf)
    end,
  },
}
