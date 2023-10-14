return {
  -- themes
  { "ellisonleao/gruvbox.nvim" },
  { "folke/tokyonight.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "i3d/vim-jimbothemes" },
  { "pineapplegiant/spaceduck" },
  { "ayu-theme/ayu-vim" },
  { "wadackel/vim-dogrun" },
  { "whatyouhide/vim-gotham" },
  { "cseelus/vim-colors-lucid" },
  { "dikiaap/minimalist" },
  { "tomasr/molokai" },
  { "fmoralesc/molokayo" },
  { "rakr/vim-one" },
  { "mhartington/oceanic-next" },
  { "kyoz/purify" },
  { "liuchengxu/space-vim-dark" },
  { "jaredgorski/SpaceCamp" },
  { "nikolvs/vim-sunbather" },

  -- Configure LazyVim to load gruvbox
  -- {
  --   "ellison/gruvbox.nvim",
  --   opt = {
  --     transparent = true,
  --     colorscheme = "gruvbox",
  --     styles = {
  --       sidebars = "transparent",
  --       float = "transparent",
  --       -- transparent_mode = true,
  --     },
  --   },
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
}
