return {
  "akinsho/toggleterm.nvim",
  version = "v2.*",
  config = function()
    require("toggleterm").setup({
      on_open = function(terminal)
        local nvimtree_view = require("nvim-tree.view")
        if nvimtree_view.is_visible() and terminal.direction == "horizontal" then
          require("nvim-tree.api").tree.toggle({ find_file = false, focus = false })
          require("nvim-tree.api").tree.toggle({ find_file = false, focus = false })
        end
      end,
      start_in_insert = true,
      autochdir = true,
      highlights = {
        Normal = {
          link = "TermNormal",
        },
        SignColumn = {
          link = "TermSignColumn",
        },
        WinBar = {
          link = "WinBar",
        },
        WinBarNC = {
          link = "WinBarNC",
        },
        StatusLine = {
          link = "StatusLine",
        },
        StatusLineNC = {
          link = "StatusLineNC",
        },
      },
    })
  end,
}
