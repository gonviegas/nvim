return {
  'goolord/alpha-nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
      "                                                     ",
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("w", "  > Workspaces", ":Telescope workspaces<CR>"),
      dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
      dashboard.button("s", "  > Settings", ":cd ~/.config/nvim | NvimTreeOpen .<CR>"),
      dashboard.button("l", "  > Lazy", "<CMD>Lazy<CR>"),
      dashboard.button("m", "  > Mason", "<CMD>Mason<CR>"),
      dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
    }

    require('alpha').setup(dashboard.opts)

    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end
}
