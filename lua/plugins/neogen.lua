return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  version = "*",
  config = function()
    require("neogen").setup({
      snippet_engine = "luasnip"
    })
  end
}
