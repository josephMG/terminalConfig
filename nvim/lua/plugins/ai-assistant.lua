return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for better prompt input, and required to use `opencode.nvim`'s embedded terminal — otherwise optional
      { "folke/snacks.nvim", opts = { input = { enabled = true } } },
    },
    config = function()
      vim.g.opencode_opts = {
        -- Your configuration, if any — see `lua/opencode/config.lua`
      }

      -- Required for `opts.auto_reload`
      vim.opt.autoread = true

      -- Recommended keymaps
      vim.keymap.set("n", "<leader>ot", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })
      vim.keymap.set("n", "<leader>oA", function()
        require("opencode").ask()
      end, { desc = "Ask opencode" })
      vim.keymap.set("n", "<leader>oa", function()
        require("opencode").ask("@cursor: ")
      end, { desc = "Ask opencode about this" })
      vim.keymap.set("v", "<leader>oa", function()
        require("opencode").ask("@selection: ")
      end, { desc = "Ask opencode about selection" })
      vim.keymap.set("n", "<leader>on", function()
        require("opencode").command("session_new")
      end, { desc = "New opencode session" })
      vim.keymap.set("n", "<leader>oy", function()
        require("opencode").command("messages_copy")
      end, { desc = "Copy last opencode response" })
      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command("messages_half_page_up")
      end, { desc = "Messages half page up" })
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command("messages_half_page_down")
      end, { desc = "Messages half page down" })
      vim.keymap.set({ "n", "v" }, "<leader>os", function()
        require("opencode").select()
      end, { desc = "Select opencode prompt" })

      -- Example: keymap for custom prompt
      vim.keymap.set("n", "<leader>oe", function()
        require("opencode").prompt("Explain @cursor and its context")
      end, { desc = "Explain this code" })
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    opts = {
      system_prompt = "You are a helpful assistant. Do not provide any explanation when you answer me and just give the response directly.",
      debug = true,
      cursor_applying_provider = "ollama",
      auto_suggestion_provider = "ollama",
      -- cursor_applying_provider = "groq",
      behaviour = {
        enable_cursor_planning_mode = true,
      },
      provider = "gemini",

      providers = {
        gemini = {
          api_key_name = "GEMINI_API_KEY",
          model = "gemini-2.5-pro",
          timeout = 30000, -- Timeout in milliseconds
          temperature = 0,
          -- max_tokens = 8192,
        },
        ollama = {
          -- endpoint = "http://127.0.0.1:11434",
          endpoint = "http://host.docker.internal:11434",
          model = "gpt-oss:20b",
          -- model = "deepseek-r1:1.5b",
          -- disable_tools = true,
          -- mode = "legacy",
          -- extra_request_body = {
          --   options = {
          --     think = false,
          --   },
          -- },
        },
        groq = {
          -- https://console.groq.com/docs/models
          __inherited_from = "openai",
          api_key_name = "GROQ_API_KEY",
          endpoint = "https://api.groq.com/openai/v1/",
          model = "meta-llama/llama-4-scout-17b-16e-instruct",
          max_tokens = 8192, -- remember to increase this value, otherwise it will stop generating halfway
        },
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
        http = {
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
              -- model = "qwen3:4b",
              model = "gemma3:4b",
            },
            system_prompt = "I am an AI meticulously crafted to provide programming guidance and code assistance. "
              .. "To best serve you as a computer programmer, please provide detailed inquiries and code snippets when necessary, "
              .. "and expect precise, technical responses tailored to your development needs.\n",
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
        hooks = {
          -- example of usig enew as a function specifying type for the new buffer
          CodeReview = function(gp, params)
            local template = "I have the following code from {{filename}}:\n\n"
              .. "```{{filetype}}\n{{selection}}\n```\n\n"
              .. "Please analyze for code smells and suggest improvements."
            local agent = gp.get_chat_agent()
            gp.Prompt(params, gp.Target.enew("markdown"), agent, template)
          end,
          -- example of making :%GpChatNew a dedicated command which
          -- opens new chat with the entire current buffer as a context
          BufferChatNew = function(gp, _)
            -- call GpChatNew command in range mode on whole buffer
            vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
          end,
          -- ReactIconSvg = function(gp, params)
          --   local buf = vim.api.nvim_get_current_buf()
          --   local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
          --   local content = table.concat(lines, "\n")
          --   local template = "The following SVG code needs to be converted into a valid React component:\n\n"
          --     .. "INPUT:\n"
          --     .. "```tsx\n"
          --     .. content
          --     .. "```\n\n"
          --     .. "  - Remove the `width` and `height` props from the `<svg>` element\n"
          --     .. "  - Add `{...props}` to the bottom of the `<svg>` element\n"
          --     .. "  - Replace all `fill` values with `currentColor`\n"
          --     .. "  - Replace all props that are dash-separated (ex: `fill-rule`) with camelCase (ex: `fillRule`)\n"
          --     .. "  - Don't remove any other props or attributes\n"
          --     .. "  - Preserve the indentation rules\n"
          --     .. "  - Only include the code snippet, no additional context or explanation is needed."
          --   local agent = gp.get_command_agent()
          --   gp.logger.info("Updating React SVG: " .. agent.name)
          --   gp.Prompt(params, gp.Target.rewrite, agent, template, nil)
          -- end,
          UiIconExport = function(gp, params)
            local template = "The following React modules need to be refactored and properly exported:\n\n"
              .. "```tsx\n{{selection}}\n```\n\n"
              .. "  - Take the unused import at the bottom of the file and move it up to the other imports in the alphabetical orrder\n"
              .. "  - Export the unsed import in the `icons` array in alphabetical order\n"
              .. "  - Export the unsed import in the `export {` object in alphabetical order\n"
              .. "  - Only include the code snippet, no additional context or explanation is needed."
            local agent = gp.get_command_agent()
            gp.logger.info("Updating React SVG: " .. agent.name)
            gp.Prompt(params, gp.Target.rewrite, agent, template, nil)
          end,
          Translator = function(gp, params)
            local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
            gp.cmd.ChatNew(params, chat_system_prompt)

            -- -- you can also create a chat with a specific fixed agent like this:
            -- local agent = gp.get_chat_agent("ChatGPT4o")
            -- gp.cmd.ChatNew(params, chat_system_prompt, agent)
          end,
        },
      }
      require("gp").setup(conf)

      require("which-key").add({
        -- VISUAL mode mappings
        -- s, x, v modes are handled the same way by which_key
        {
          mode = { "v" },
          nowait = true,
          remap = false,
          { "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = "ChatNew tabnew" },
          { "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = "ChatNew vsplit" },
          { "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", desc = "ChatNew split" },
          { "<C-g>a", ":<C-u>'<,'>GpAppend<cr>", desc = "Visual Append (after)" },
          { "<C-g>b", ":<C-u>'<,'>GpPrepend<cr>", desc = "Visual Prepend (before)" },
          { "<C-g>c", ":<C-u>'<,'>GpChatNew<cr>", desc = "Visual Chat New" },
          { "<C-g>g", group = "generate into new .." },
          { "<C-g>ge", ":<C-u>'<,'>GpEnew<cr>", desc = "Visual GpEnew" },
          { "<C-g>gn", ":<C-u>'<,'>GpNew<cr>", desc = "Visual GpNew" },
          { "<C-g>gp", ":<C-u>'<,'>GpPopup<cr>", desc = "Visual Popup" },
          { "<C-g>gt", ":<C-u>'<,'>GpTabnew<cr>", desc = "Visual GpTabnew" },
          { "<C-g>gv", ":<C-u>'<,'>GpVnew<cr>", desc = "Visual GpVnew" },
          { "<C-g>i", ":<C-u>'<,'>GpImplement<cr>", desc = "Implement selection" },
          { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
          { "<C-g>p", ":<C-u>'<,'>GpChatPaste<cr>", desc = "Visual Chat Paste" },
          { "<C-g>r", ":<C-u>'<,'>GpRewrite<cr>", desc = "Visual Rewrite" },
          { "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
          { "<C-g>t", ":<C-u>'<,'>GpChatToggle<cr>", desc = "Visual Toggle Chat" },
          { "<C-g>w", group = "Whisper" },
          { "<C-g>wa", ":<C-u>'<,'>GpWhisperAppend<cr>", desc = "Whisper Append" },
          { "<C-g>wb", ":<C-u>'<,'>GpWhisperPrepend<cr>", desc = "Whisper Prepend" },
          { "<C-g>we", ":<C-u>'<,'>GpWhisperEnew<cr>", desc = "Whisper Enew" },
          { "<C-g>wn", ":<C-u>'<,'>GpWhisperNew<cr>", desc = "Whisper New" },
          { "<C-g>wp", ":<C-u>'<,'>GpWhisperPopup<cr>", desc = "Whisper Popup" },
          { "<C-g>wr", ":<C-u>'<,'>GpWhisperRewrite<cr>", desc = "Whisper Rewrite" },
          { "<C-g>wt", ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
          { "<C-g>wv", ":<C-u>'<,'>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
          { "<C-g>ww", ":<C-u>'<,'>GpWhisper<cr>", desc = "Whisper" },
          { "<C-g>x", ":<C-u>'<,'>GpContext<cr>", desc = "Visual GpContext" },
        },

        -- NORMAL mode mappings
        {
          mode = { "n" },
          nowait = true,
          remap = false,
          { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "New Chat tabnew" },
          { "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" },
          { "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "New Chat split" },
          { "<C-g>a", "<cmd>GpAppend<cr>", desc = "Append (after)" },
          { "<C-g>b", "<cmd>GpPrepend<cr>", desc = "Prepend (before)" },
          { "<C-g>c", "<cmd>GpChatNew<cr>", desc = "New Chat" },
          { "<C-g>f", "<cmd>GpChatFinder<cr>", desc = "Chat Finder" },
          { "<C-g>g", group = "generate into new .." },
          { "<C-g>ge", "<cmd>GpEnew<cr>", desc = "GpEnew" },
          { "<C-g>gn", "<cmd>GpNew<cr>", desc = "GpNew" },
          { "<C-g>gp", "<cmd>GpPopup<cr>", desc = "Popup" },
          { "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "GpTabnew" },
          { "<C-g>gv", "<cmd>GpVnew<cr>", desc = "GpVnew" },
          { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
          { "<C-g>r", "<cmd>GpRewrite<cr>", desc = "Inline Rewrite" },
          { "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
          { "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "Toggle Chat" },
          { "<C-g>w", group = "Whisper" },
          { "<C-g>wa", "<cmd>GpWhisperAppend<cr>", desc = "Whisper Append (after)" },
          { "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", desc = "Whisper Prepend (before)" },
          { "<C-g>we", "<cmd>GpWhisperEnew<cr>", desc = "Whisper Enew" },
          { "<C-g>wn", "<cmd>GpWhisperNew<cr>", desc = "Whisper New" },
          { "<C-g>wp", "<cmd>GpWhisperPopup<cr>", desc = "Whisper Popup" },
          { "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", desc = "Whisper Inline Rewrite" },
          { "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
          { "<C-g>wv", "<cmd>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
          { "<C-g>ww", "<cmd>GpWhisper<cr>", desc = "Whisper" },
          { "<C-g>x", "<cmd>GpContext<cr>", desc = "Toggle GpContext" },
        },

        -- INSERT mode mappings
        {
          mode = { "i" },
          nowait = true,
          remap = false,
          { "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", desc = "New Chat tabnew" },
          { "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat vsplit" },
          { "<C-g><C-x>", "<cmd>GpChatNew split<cr>", desc = "New Chat split" },
          { "<C-g>a", "<cmd>GpAppend<cr>", desc = "Append (after)" },
          { "<C-g>b", "<cmd>GpPrepend<cr>", desc = "Prepend (before)" },
          { "<C-g>c", "<cmd>GpChatNew<cr>", desc = "New Chat" },
          { "<C-g>f", "<cmd>GpChatFinder<cr>", desc = "Chat Finder" },
          { "<C-g>g", group = "generate into new .." },
          { "<C-g>ge", "<cmd>GpEnew<cr>", desc = "GpEnew" },
          { "<C-g>gn", "<cmd>GpNew<cr>", desc = "GpNew" },
          { "<C-g>gp", "<cmd>GpPopup<cr>", desc = "Popup" },
          { "<C-g>gt", "<cmd>GpTabnew<cr>", desc = "GpTabnew" },
          { "<C-g>gv", "<cmd>GpVnew<cr>", desc = "GpVnew" },
          { "<C-g>n", "<cmd>GpNextAgent<cr>", desc = "Next Agent" },
          { "<C-g>r", "<cmd>GpRewrite<cr>", desc = "Inline Rewrite" },
          { "<C-g>s", "<cmd>GpStop<cr>", desc = "GpStop" },
          { "<C-g>t", "<cmd>GpChatToggle<cr>", desc = "Toggle Chat" },
          { "<C-g>w", group = "Whisper" },
          { "<C-g>wa", "<cmd>GpWhisperAppend<cr>", desc = "Whisper Append (after)" },
          { "<C-g>wb", "<cmd>GpWhisperPrepend<cr>", desc = "Whisper Prepend (before)" },
          { "<C-g>we", "<cmd>GpWhisperEnew<cr>", desc = "Whisper Enew" },
          { "<C-g>wn", "<cmd>GpWhisperNew<cr>", desc = "Whisper New" },
          { "<C-g>wp", "<cmd>GpWhisperPopup<cr>", desc = "Whisper Popup" },
          { "<C-g>wr", "<cmd>GpWhisperRewrite<cr>", desc = "Whisper Inline Rewrite" },
          { "<C-g>wt", "<cmd>GpWhisperTabnew<cr>", desc = "Whisper Tabnew" },
          { "<C-g>wv", "<cmd>GpWhisperVnew<cr>", desc = "Whisper Vnew" },
          { "<C-g>ww", "<cmd>GpWhisper<cr>", desc = "Whisper" },
          { "<C-g>x", "<cmd>GpContext<cr>", desc = "Toggle GpContext" },
        },
      })
    end,
  },
}
