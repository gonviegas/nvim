return {
  "nvimdev/lspsaga.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
  config = function()
    vim.cmd("hi! link SagaNormal NormalFloat")

    require("lspsaga").setup({
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
      ui = {
        title = false,
        border = "rounded",
      },
      diagnostic = {
        show_source = true,
        custom_msg = "Diagnostic:",
        custom_fix = "Fix:",
        border_follow = false,
      },
      rename = {
        in_select = false,
        keys = {
          exec = "<CR>",
          quit = "<Esc>",
        },
      },
    })
  end,
}
