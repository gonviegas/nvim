return {
  "lazytanuki/nvim-mapper",
  dependencies = { "telescope.nvim" },
  config = function()
    local mapper = require("nvim-mapper")
    mapper.setup({
      no_map = true,
    })
  end
}
