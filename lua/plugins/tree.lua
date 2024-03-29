return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup({
      sync_root_with_cwd = true,
      diagnostics = {
        severity = {
          min = vim.diagnostic.severity.WARN,
          max = vim.diagnostic.severity.ERROR,
        },
        enable = true,
        icons = {
          hint = "󰌶",
          info = "",
          warning = "",
          error = "󰅚",
        },
      },
      renderer = {
        highlight_opened_files = "name",
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = true,
        },
        icons = {
          git_placement = "after",
        },
        root_folder_label = false,
      },
      filters = {
        custom = { "^\\.git" },
      },
      update_focused_file = {
        enable = true,
      },
      view = {
        cursorline = true,
        adaptive_size = true,
      },
    })
  end,
}
