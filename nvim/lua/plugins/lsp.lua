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
}
