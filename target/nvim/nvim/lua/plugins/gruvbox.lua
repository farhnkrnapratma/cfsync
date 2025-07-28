return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = "dark"
      vim.opt.termguicolors = true
      vim.g.default_colorscheme = "gruvbox"
      require("gruvbox").setup({
        contrast = "soft",
        italic = {
          strings = true,
          comments = true,
          operators = false,
          folds = true,
          emphasis = true,
        },
        overrides = {},
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}

