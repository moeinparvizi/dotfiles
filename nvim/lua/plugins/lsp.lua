return {
  -- neodev
  {
    "folke/neodev.nvim",
    opts = {
      debug = true,
      experimental = {
        pathStrict = true,
      },
      library = {
        runtime = "~/projects/neovim/runtime/",
      },
    },
  },

  -- tools
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    init = function()
      -- disable lsp watcher. Too slow on linux
      local ok, wf = pcall(require, "vim.lsp._watchfiles")
      if ok then
        wf._watchfunc = function()
          return function() end
        end
      end
    end,
    opts = {
      inlay_hints = { enabled = true },
      ---@type lspconfig.options
      servers = {
        -- rome = {
        --   root_dir = function(fname)
        --     return require("lspconfig").util.root_pattern("rome.json")(fname)
        --   end,
        --   mason = false,
        --   settings = {
        --     rome = {
        --       rename = true,
        --       -- requireConfiguration = true,
        --     },
        --   },
        -- },
        ansiblels = {},
        bashls = {},
        clangd = {},
        -- denols = {},
        cssls = {},
        dockerls = {},
        ruff_lsp = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        -- svelte = {},
        html = {},
        gopls = {},
        marksman = {},
        pyright = {
          enabled = false,
        },
        rust_analyzer = {
          -- settings = {
          --   ["rust-analyzer"] = {
          --     procMacro = { enable = true },
          --     cargo = { allFeatures = true },
          --     checkOnSave = {
          --       command = "clippy",
          --       extraArgs = { "--no-deps" },
          --     },
          --   },
          -- },
        },
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          -- enabled = false,
          -- cmd = { "/home/folke/projects/lua-language-server/bin/lua-language-server" },
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
        vimls = {},
      },
      setup = {},
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = { virtual_text = { prefix = "icons" } },
      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },

  {
    "norcalli/nvim-colorizer.lua",
  },
  -- null-ls
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- dev = true,
    -- opts = function(_, opts)
    --   local nls = require("null-ls")
    --   vim.list_extend(opts.sources, {
    --     nls.builtins.formatting.dprint.with({
    --       condition = function(utils)
    --         return utils.root_has_file({ "dprint.json" }) or vim.loop.fs_stat("dprint.json")
    --       end,
    --     }),
    --     nls.builtins.formatting.prettier.with({ filetypes = { "markdown" } }),
    --     nls.builtins.diagnostics.markdownlint,
    --     nls.builtins.diagnostics.deno_lint,
    --     nls.builtins.diagnostics.selene.with({
    --       condition = function(utils)
    --         return utils.root_has_file({ "selene.toml" })
    --       end,
    --     }),
    --     nls.builtins.formatting.isort,
    --     nls.builtins.formatting.black,
    --     nls.builtins.diagnostics.flake8,
    --     nls.builtins.diagnostics.luacheck.with({
    --       condition = function(utils)
    --         return utils.root_has_file({ ".luacheckrc" })
    --       end,
    --     }),
    --   })
    -- end,
  },
  -- {
  --   "derektata/lorem.nvim",
  --   -- opts = {
  --   --   setup = {
  --   --     sentenceLength = "mixedShort",
  --   --     comma = 0.1,
  --   --   },
  --   -- },
  -- },
  {
    "kabouzeid/nvim-lspinstall",
  },
  {
    "barrett-ruth/live-server.nvim",
    build = "yarn global add live-server",
    config = true,
  },
  {
    "https://github.com/adelarsq/image_preview.nvim",
    event = "VeryLazy",
    config = function()
      require("image_preview").setup()
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    opts = function()
      local dashboard = require("alpha.themes.dashboard")
      local logo = [[
 ███▄ ▄███▓ ▒█████  ▓█████  ██▓ ███▄    █     ██▓███   ▄▄▄       ██▀███   ██▒   █▓ ██▓▒███████▒ ██▓
▓██▒▀█▀ ██▒▒██▒  ██▒▓█   ▀ ▓██▒ ██ ▀█   █    ▓██░  ██▒▒████▄    ▓██ ▒ ██▒▓██░   █▒▓██▒▒ ▒ ▒ ▄▀░▓██▒
▓██    ▓██░▒██░  ██▒▒███   ▒██▒▓██  ▀█ ██▒   ▓██░ ██▓▒▒██  ▀█▄  ▓██ ░▄█ ▒ ▓██  █▒░▒██▒░ ▒ ▄▀▒░ ▒██▒
▒██    ▒██ ▒██   ██░▒▓█  ▄ ░██░▓██▒  ▐▌██▒   ▒██▄█▓▒ ▒░██▄▄▄▄██ ▒██▀▀█▄    ▒██ █░░░██░  ▄▀▒   ░░██░
▒██▒   ░██▒░ ████▓▒░░▒████▒░██░▒██░   ▓██░   ▒██▒ ░  ░ ▓█   ▓██▒░██▓ ▒██▒   ▒▀█░  ░██░▒███████▒░██░
░ ▒░   ░  ░░ ▒░▒░▒░ ░░ ▒░ ░░▓  ░ ▒░   ▒ ▒    ▒▓▒░ ░  ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░   ░ ▐░  ░▓  ░▒▒ ▓░▒░▒░▓  
░  ░      ░  ░ ▒ ▒░  ░ ░  ░ ▒ ░░ ░░   ░ ▒░   ░▒ ░       ▒   ▒▒ ░  ░▒ ░ ▒░   ░ ░░   ▒ ░░░▒ ▒ ░ ▒ ▒ ░
░      ░   ░ ░ ░ ▒     ░    ▒ ░   ░   ░ ░    ░░         ░   ▒     ░░   ░      ░░   ▒ ░░ ░ ░ ░ ░ ▒ ░
       ░       ░ ░     ░  ░ ░           ░                   ░  ░   ░           ░   ░    ░ ░     ░  
                                                                              ░       ░            
    ]]

      dashboard.section.header.val = vim.split(logo, "\n")
      dashboard.section.buttons.val = {
        dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
        dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
        dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
        dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
        dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
        dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
        dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
        dashboard.button("q", " " .. " Quit", ":qa<CR>"),
      }
      for _, button in ipairs(dashboard.section.buttons.val) do
        button.opts.hl = "AlphaButtons"
        button.opts.hl_shortcut = "AlphaShortcut"
      end
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"
      dashboard.opts.layout[1].val = 8
      return dashboard
    end,
    config = function(_, dashboard)
      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
          pcall(vim.cmd.AlphaRedraw)
        end,
      })
    end,
  },
  {
    -- alt + r rgb(255, 255, 255)
    -- alt + w rgba(255, 255, 255, 1)
    -- alt + v hsl(0, 0%, 100%)
    -- alt + c #FFFFFF
    "KabbAmine/vCoolor.vim",
    -- keys = function()
    --   return {
    --     { "<leader>r", desc = "color picker>alt+r or alt+w or alt+v" },
    --   }
    -- end,
  },
  {
    "anuvyklack/pretty-fold.nvim",
    config = function()
      require("pretty-fold").setup()
    end,
  },
  {
    "mg979/vim-visual-multi",
  },
  {
    "rcarriga/nvim-notify",
    -- enabled = false,
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 2000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      -- when noice is not enabled, install notify on VeryLazy
      local Util = require("lazyvim.util")
      if not Util.has("noice.nvim") then
        Util.on_very_lazy(function()
          vim.notify = require("notify")
        end)
      end
    end,
  },
  -- {
  --   "huggingface/hfcc.nvim",
  --   -- enabled = false,
  --   opts = {
  --     api_token = "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",
  --     model = "bigcode/starcoder",
  --     query_params = {
  --       max_new_tokens = 200,
  --     },
  --   },
  --   init = function()
  --     vim.api.nvim_create_user_command("StarCoder", function()
  --       require("hfcc.completion").complete()
  --     end, {})
  --   end,
  -- },
  -- {
  --   "aduros/ai.vim",
  -- },
  -- { "Bryley/neoai.nvim",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   },
  --   cmd = {
  --     "NeoAI",
  --     "NeoAIOpen",
  --     "NeoAIClose",
  --     "NeoAIToggle",
  --     "NeoAIContext",
  --     "NeoAIContextOpen",
  --     "NeoAIContextClose",
  --     "NeoAIInject",
  --     "NeoAIInjectCode",
  --     "NeoAIInjectContext",
  --     "NeoAIInjectContextCode",
  --   },
  --   keys = {
  --     { "<leader>as", desc = "summarize text" },
  --     { "<leader>ag", desc = "generate git message" },
  --   },
  --   config = function()
  --     require("neoai").setup({
  --       -- Options go here
  --     })
  --   end,
  -- },
  -- {
  --   "Exafunction/codeium.vim",
  --   event = "BufEnter",
  --   -- config = function()
  --   --   -- Change '<C-g>' here to any keycode you like.
  --   --   vim.keymap.set("i", "<C-g>", function()
  --   --     return vim.fn["codeium#Accept"]()
  --   --   end, { expr = true })
  --   --   vim.keymap.set("i", "<c-;>", function()
  --   --     return vim.fn["codeium#CycleCompletions"](1)
  --   --   end, { expr = true })
  --   --   vim.keymap.set("i", "<c-,>", function()
  --   --     return vim.fn["codeium#CycleCompletions"](-1)
  --   --   end, { expr = true })
  --   --   vim.keymap.set("i", "<c-x>", function()
  --   --     return vim.fn["codeium#Clear"]()
  --   --   end, { expr = true })
  --   -- end,
  -- },
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       panel = {
  --         enabled = true,
  --         auto_refresh = false,
  --         keymap = {
  --           jump_prev = "[[",
  --           jump_next = "]]",
  --           accept = "<CR>",
  --           refresh = "gr",
  --           open = "<M-CR>",
  --         },
  --         layout = {
  --           position = "bottom", -- | top | left | right
  --           ratio = 0.4,
  --         },
  --       },
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = false,
  --         debounce = 75,
  --         keymap = {
  --           accept = "<M-l>",
  --           accept_word = false,
  --           accept_line = false,
  --           next = "<M-]>",
  --           prev = "<M-[>",
  --           dismiss = "<C-]>",
  --         },
  --       },
  --       filetypes = {
  --         yaml = false,
  --         markdown = false,
  --         help = false,
  --         gitcommit = false,
  --         gitrebase = false,
  --         hgcommit = false,
  --         svn = false,
  --         cvs = false,
  --         ["."] = false,
  --       },
  --       copilot_node_command = "node", -- Node.js version must be > 16.x
  --       server_opts_overrides = {},
  --     })
  --   end,
  -- },
  --
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons
      local Util = require("lazyvim.util")

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
          -- stylua: ignore
          {
            function() return require("nvim-navic").get_location() end,
            cond = function() return package.loaded["nvim-navic"] and require("nvim-navic").is_available() end,
          },
          },
          lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = Util.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = Util.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = Util.fg("Debug"),
          },
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = Util.fg("Special") },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
            },
          },
          lualine_y = {
            { "progress", separator = " ", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}
