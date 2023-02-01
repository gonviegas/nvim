return {
  'lukas-reineke/indent-blankline.nvim', -- Add indentation guides even on blank lines
  config = function()

    local d = require("settings.colors").Default()

    vim.cmd [[highlight IndentBlanklineIndent1 guifg=#181818 guibg=#181818 gui=nocombine]]
    vim.cmd('highlight IndentBlanklineIndent2 guifg=' .. d.normal .. ' guibg=' .. d.normal .. ' gui=nocombine')
    vim.cmd [[highlight IndentBlanklineContextChar1 guifg=#569cd6 guibg=#181818 gui=nocombine]]
    vim.cmd('highlight IndentBlanklineContextChar2 guifg=#569cd6 guibg=' .. d.normal .. ' gui=nocombine')

    require("indent_blankline").setup {
      show_end_of_line = false,
      show_current_context_start_on_current_line = true,
      space_char_blankline = " ",
      show_current_context = true,
      show_current_context_start = false,
      char = '',
      context_char_list = { '▏', '▏' },
      context_highlight_list = {
        "IndentBlanklineContextChar1",
        "IndentBlanklineContextChar2",
      },
      char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
      },
      space_char_highlight_list = {
        "IndentBlanklineIndent1",
        "IndentBlanklineIndent2",
      },
      show_trailing_blankline_indent = false,
    }
  end
}
