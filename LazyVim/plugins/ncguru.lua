-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add catppuccin
    { "catppuccin/nvim" },
    -- add monokai pro
    {"loctvl842/monokai-pro.nvim"},
    -- add gruvbox
    {
        "ellisonleao/gruvbox.nvim",
    opts = {
      terminal_colors = true, -- add neovim terminal colors
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = true,
        comments = false,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {
        ["String"] = { fg = "#A9D08E" },
        --["String"] = {fg = "#FFC000"},
      },
      dim_inactive = false,
      transparent_mode = false,
    },
  },
  -- add tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
      light_style = "day", -- The theme is used when the background is set to light
      transparent = true, -- Enable this to disable setting the background color
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = false },
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  -- Configure lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_x = { "encoding", "fileformat", "filetype" },
      },
    },
  },

  -- Configure telescope-fzf-native
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },
  -- im_select
  {
    "pepo-le/win-ime-con.nvim",
  },
  -- dashboard disable
  {
    "nvimdev/dashboard-nvim",
    enabled = false,
  },
  -- start screen
  {
    "mhinz/vim-startify",
  },
  -- rainbow-delimiters
  {
    "HiPhish/rainbow-delimiters.nvim",
  },
  -- LSP
  {
    "neovim/nvim-lspconfig",
    enabled = true,
  },
  -- notify
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 6000,
    },
  },
}
