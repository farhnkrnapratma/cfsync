return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}

    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
    keymap("n", "<C-e>", ":NvimTreeFocus<CR>", opts)
    keymap("n", "<C-w>", "<C-w>p", opts)

    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        local wins = vim.api.nvim_list_wins()
        local valid = 0
        for _, win in ipairs(wins) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.api.nvim_buf_get_option(buf, "filetype")
          if ft ~= "NvimTree" then
            valid = valid + 1
          end
        end
        if valid == 0 then
          vim.cmd("quit")
        end
      end,
    })
  end,
}
