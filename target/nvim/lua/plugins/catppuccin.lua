return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup {
        flavour = "mocha",
        transparent_background = true,
        term_colors = true,
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          telescope = true,
          lsp_trouble = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          notify = true,
          mini = true,
        },
      }
      vim.cmd.colorscheme "catppuccin"
    end,
  },
}

