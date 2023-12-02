return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
  enabled = true,
  config = function()
    local highlight = {
      "RainbowDelimiterRed",
      "RainbowDelimiterYellow",
      "RainbowDelimiterBlue",
      "RainbowDelimiterOrange",
      "RainbowDelimiterGreen",
      "RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    }
    vim.g.rainbow_delimiters = { highlight = highlight }

    require("ibl").setup({
      indent = { char = "▏", tab_char = "▏" },
      scope = {
        char = "▏",
        highlight = highlight,
        show_start = true,
        show_end = true,
      },
      debounce = 200,
    })

    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  end,
}
