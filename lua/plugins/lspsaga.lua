return {
  'glepnir/lspsaga.nvim',
  event = 'BufRead',
  config = function()
    vim.cmd("hi! link SagaNormal NormalFloat")

    require('lspsaga').setup({
      symbol_in_winbar = {
        enable = false,
      },
      lightbulb = {
        enable = false,
      },
      ui = {
        title = false,
        border = "rounded"
      },
    })
  end
}
