return {
  "dstein64/nvim-scrollview",
  -- enabled = false,
  config = function()
    require("scrollview").setup({
      excluded_filetypes = { "NvimTree" },
      current_only = true,
      column = 1,
      signs_on_startup = { "folds" },
      winblend = 60,
    })
  end,
}
