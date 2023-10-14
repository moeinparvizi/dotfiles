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
    -- "nvimtools/none-ls.nvim",
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
    "adelarsq/image_preview.nvim",
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
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
    -- stylua: ignore
    dashboard.section.buttons.val = {
      dashboard.button("f", " " .. " Find file",       "<cmd> Telescope find_files <cr>"),
      dashboard.button("n", " " .. " New file",        "<cmd> ene <BAR> startinsert <cr>"),
      dashboard.button("r", " " .. " Recent files",    "<cmd> Telescope oldfiles <cr>"),
      dashboard.button("g", " " .. " Find text",       "<cmd> Telescope live_grep <cr>"),
      dashboard.button("c", " " .. " Config",          "<cmd> e $MYVIMRC <cr>"),
      dashboard.button("s", " " .. " Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
      dashboard.button("e", " " .. " Lazy Extras",     "<cmd> LazyExtras <cr>"),
      dashboard.button("l", "󰒲 " .. " Lazy",            "<cmd> Lazy <cr>"),
      dashboard.button("q", " " .. " Quit",            "<cmd> qa <cr>"),
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
          once = true,
          pattern = "AlphaReady",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      require("alpha").setup(dashboard.opts)

      vim.api.nvim_create_autocmd("User", {
        once = true,
        pattern = "LazyVimStarted",
        callback = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          dashboard.section.footer.val = "⚡ Neovim loaded "
            .. stats.loaded
            .. "/"
            .. stats.count
            .. " plugins in "
            .. ms
            .. "ms"
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
  -- {
  --   "rcarriga/nvim-notify",
  --   -- enabled = false,
  --   keys = {
  --     {
  --       "<leader>un",
  --       function()
  --         require("notify").dismiss({ silent = true, pending = true })
  --       end,
  --       desc = "Dismiss all Notifications",
  --     },
  --   },
  --   opts = {
  --     timeout = 2000,
  --     max_height = function()
  --       return math.floor(vim.o.lines * 0.75)
  --     end,
  --     max_width = function()
  --       return math.floor(vim.o.columns * 0.75)
  --     end,
  --   },
  --   init = function()
  --     -- when noice is not enabled, install notify on VeryLazy
  --     local Util = require("lazyvim.util").ui
  --     if not Util.has("noice.nvim") then
  --       Util.on_very_lazy(function()
  --         vim.notify = require("notify")
  --       end)
  --     end
  --   end,
  -- },
  {
    "huggingface/hfcc.nvim",
    -- enabled = false,
    opts = {
      api_token = "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",
      model = "bigcode/starcoder",
      query_params = {
        max_new_tokens = 200,
      },
    },
    init = function()
      vim.api.nvim_create_user_command("StarCoder", function()
        require("hfcc.completion").complete()
      end, {})
    end,
  },
  {
    "aduros/ai.vim",
  },
  {
    "Bryley/neoai.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    cmd = {
      "NeoAI",
      "NeoAIOpen",
      "NeoAIClose",
      "NeoAIToggle",
      "NeoAIContext",
      "NeoAIContextOpen",
      "NeoAIContextClose",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
    },
    keys = {
      { "<leader>as", desc = "summarize text" },
      { "<leader>ag", desc = "generate git message" },
    },
    config = function()
      require("neoai").setup({
        -- Options go here
      })
    end,
  },
  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-g>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
      vim.keymap.set("i", "<c-;>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true })
      vim.keymap.set("i", "<c-,>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true })
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 16.x
        server_opts_overrides = {},
      })
    end,
  },
  --
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons
      local Util = require("lazyvim.util").ui

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
  { "Jezda1337/cmp_bootstrap" },
  { "xiyaowong/transparent.nvim" },
  {
    "github/copilot.vim",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = { enabled = true },
      panel = { enabled = true },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  { "Exafunction/codeium.vim" },
  {
    "echasnovski/mini.surround",
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
      local opts = require("lazy.core.plugin").values(plugin, "opts", false)
      local mappings = {
        { opts.mappings.add, desc = "Add surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete surrounding" },
        { opts.mappings.find, desc = "Find right surrounding" },
        { opts.mappings.find_left, desc = "Find left surrounding" },
        { opts.mappings.highlight, desc = "Highlight surrounding" },
        { opts.mappings.replace, desc = "Replace surrounding" },
        { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "gsa", -- Add surrounding in Normal and Visual modes
        delete = "gsd", -- Delete surrounding
        find = "gsf", -- Find surrounding (to the right)
        find_left = "gsF", -- Find surrounding (to the left)
        highlight = "gsh", -- Highlight surrounding
        replace = "gsr", -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
    },
  },
  --   {
  --     "glepnir/dashboard-nvim",
  --     event = "VimEnter",
  --     opts = function()
  --       local logo = [[
  --  ███▄ ▄███▓ ▒█████  ▓█████  ██▓ ███▄    █     ██▓███   ▄▄▄       ██▀███   ██▒   █▓ ██▓▒███████▒ ██▓
  -- ▓██▒▀█▀ ██▒▒██▒  ██▒▓█   ▀ ▓██▒ ██ ▀█   █    ▓██░  ██▒▒████▄    ▓██ ▒ ██▒▓██░   █▒▓██▒▒ ▒ ▒ ▄▀░▓██▒
  -- ▓██    ▓██░▒██░  ██▒▒███   ▒██▒▓██  ▀█ ██▒   ▓██░ ██▓▒▒██  ▀█▄  ▓██ ░▄█ ▒ ▓██  █▒░▒██▒░ ▒ ▄▀▒░ ▒██▒
  -- ▒██    ▒██ ▒██   ██░▒▓█  ▄ ░██░▓██▒  ▐▌██▒   ▒██▄█▓▒ ▒░██▄▄▄▄██ ▒██▀▀█▄    ▒██ █░░░██░  ▄▀▒   ░░██░
  -- ▒██▒   ░██▒░ ████▓▒░░▒████▒░██░▒██░   ▓██░   ▒██▒ ░  ░ ▓█   ▓██▒░██▓ ▒██▒   ▒▀█░  ░██░▒███████▒░██░
  -- ░ ▒░   ░  ░░ ▒░▒░▒░ ░░ ▒░ ░░▓  ░ ▒░   ▒ ▒    ▒▓▒░ ░  ░ ▒▒   ▓▒█░░ ▒▓ ░▒▓░   ░ ▐░  ░▓  ░▒▒ ▓░▒░▒░▓
  -- ░  ░      ░  ░ ▒ ▒░  ░ ░  ░ ▒ ░░ ░░   ░ ▒░   ░▒ ░       ▒   ▒▒ ░  ░▒ ░ ▒░   ░ ░░   ▒ ░░░▒ ▒ ░ ▒ ▒ ░
  -- ░      ░   ░ ░ ░ ▒     ░    ▒ ░   ░   ░ ░    ░░         ░   ▒     ░░   ░      ░░   ▒ ░░ ░ ░ ░ ░ ▒ ░
  --        ░       ░ ░     ░  ░ ░           ░                   ░  ░   ░           ░   ░    ░ ░     ░
  --                                                                               ░       ░
  --     ]]
  --
  --       logo = string.rep("\n", 8) .. logo .. "\n\n"
  --
  --       local opts = {
  --         theme = "doom",
  --         hide = {
  --           -- this is taken care of by lualine
  --           -- enabling this messes up the actual laststatus setting after loading a file
  --           statusline = false,
  --         },
  --         config = {
  --           header = vim.split(logo, "\n"),
  --         -- stylua: ignore
  --         center = {
  --           { action = "Telescope find_files",              desc = " Find file",       icon = " ", key = "f" },
  --           { action = "ene | startinsert",                 desc = " New file",        icon = " ", key = "n" },
  --           { action = "Telescope oldfiles",                desc = " Recent files",    icon = " ", key = "r" },
  --           { action = "Telescope live_grep",               desc = " Find text",       icon = " ", key = "g" },
  --           { action = "e $MYVIMRC",                        desc = " Config",          icon = " ", key = "c" },
  --           { action = 'lua require("persistence").load()', desc = " Restore Session", icon = " ", key = "s" },
  --           { action = "LazyExtras",                        desc = " Lazy Extras",     icon = " ", key = "e" },
  --           { action = "Lazy",                              desc = " Lazy",            icon = "󰒲 ", key = "l" },
  --           { action = "qa",                                desc = " Quit",            icon = " ", key = "q" },
  --         },
  --           footer = function()
  --             local stats = require("lazy").stats()
  --             local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
  --             return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
  --           end,
  --         },
  --       }
  --
  --       for _, button in ipairs(opts.config.center) do
  --         button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
  --       end
  --
  --       -- close Lazy and re-open when the dashboard is ready
  --       if vim.o.filetype == "lazy" then
  --         vim.cmd.close()
  --         vim.api.nvim_create_autocmd("User", {
  --           pattern = "DashboardLoaded",
  --           callback = function()
  --             require("lazy").show()
  --           end,
  --         })
  --       end
  --
  --       return opts
  --     end,
  --   },
  -- {
  --   "nvimtools/none-ls.nvim",
  --   event = "LazyFile",
  --   dependencies = { "mason.nvim" },
  --   init = function()
  --     Util.on_very_lazy(function()
  --       -- register the formatter with LazyVim
  --       require("lazyvim.util").format.register({
  --         name = "none-ls.nvim",
  --         priority = 200, -- set higher than conform, the builtin formatter
  --         primary = true,
  --         format = function(buf)
  --           return Util.lsp.format({
  --             bufnr = buf,
  --             filter = function(client)
  --               return client.name == "null-ls"
  --             end,
  --           })
  --         end,
  --         sources = function(buf)
  --           local ret = require("null-ls.sources").get_available(vim.bo[buf].filetype, "NULL_LS_FORMATTING") or {}
  --           return vim.tbl_map(function(source)
  --             return source.name
  --           end, ret)
  --         end,
  --       })
  --     end)
  --   end,
  --   opts = function(_, opts)
  --     local nls = require("null-ls")
  --     opts.root_dir = opts.root_dir
  --       or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
  --     opts.sources = vim.list_extend(opts.sources or {}, {
  --       nls.builtins.formatting.fish_indent,
  --       nls.builtins.diagnostics.fish,
  --       nls.builtins.formatting.stylua,
  --       nls.builtins.formatting.shfmt,
  --     })
  --   end,
  -- },
  {
    "rcarriga/nvim-notify",
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
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
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
}
