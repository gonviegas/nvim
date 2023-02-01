return {
  'akinsho/toggleterm.nvim',
  version = 'v2.*',
  config = function()
    require("toggleterm").setup {
      on_open = function(terminal)
        local nvimtree = require "nvim-tree"
        local nvimtree_view = require "nvim-tree.view"
        if nvimtree_view.is_visible() and terminal.direction == "horizontal" then
          nvimtree.toggle()
          nvimtree.toggle(false, true)
        end
      end,
      highlights = {
        Normal = {
          link = "Normal",
        },
        SignColumn = {
          link = "SignColumn"
        },
        WinBar = {
          link = "WinBar"
        },
        WinBarNC = {
          link = "WinBarNC"
        },
        StatusLine = {
          link = "StatusLine"
        },
        StatusLineNC = {
          link = "StatusLineNC"
        },
      },
    }
  end
}
