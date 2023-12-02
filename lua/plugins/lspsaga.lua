return {
  "glepnir/lspsaga.nvim",
  event = "BufRead",
  enable = false,
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
      rename_action_keys = {
        quit = "<Esc>",
        exec = "<CR>",
      },
    })
  end,
}
