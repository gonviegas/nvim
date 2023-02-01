return {
  'dstein64/nvim-scrollview',
  config = function()
    require("scrollview").setup({
      column = 1
    })
  end
}
