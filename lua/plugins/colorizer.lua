return {
  'NvChad/nvim-colorizer.lua',
  -- 'norcalli/nvim-colorizer.lua',
  config = function()
    require("colorizer").setup({
      filetypes = { "*" },
    })
  end
}
