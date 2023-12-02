return {
  "loctvl842/monokai-pro.nvim",
  priority = 1000,
  config = function()
    require("monokai-pro").setup({
      terminal_colors = false,
      -- filter = "spectrum",
      styles = {
        comment = { italic = true },
        keyword = { italic = true }, -- any other keyword
        type = { italic = true }, -- (preferred) int, long, char, etc
        storageclass = { italic = true }, -- static, register, volatile, etc
        structure = { italic = true }, -- struct, union, enum, etc
        parameter = { italic = true }, -- parameter pass in function
        annotation = { italic = true },
        tag_attribute = { italic = true }, -- attribute of tag in reactjs
      },

      background_clear = { "bufferline" },
      inc_search = "underline",
      plugins = {
        indent_blankline = {
          context_highlight = "pro", -- default | pro
          context_start_underline = true,
        },
        -- bufferline = {
        -- underline_selected = true,
        -- },
      },
      override = function()
        return {
          -- LineNr = {
          -- fg = d.text2
          -- }
          -- BufferLineBufferSelected = {
          -- 	fg = "#eeeeee",
          -- 	bg = "#090909",
          -- },
          -- BufferLineDevIconDefaultSelected = {
          -- 	-- fg = "#eeeeee",
          -- 	bg = "#090909",
          -- },
        }
      end,
    })
    vim.cmd("colorscheme monokai-pro-spectrum")
  end,
}
