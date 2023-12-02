return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local c = require("settings.colors").Color()
    local d = require("settings.colors").Default()
    local indicator_color = c.orange
    require("bufferline").setup({
      options = {
        mode = "buffers",
        close_command = "Bdelete",
        -- style_preset = require("bufferline").style_preset.default, -- or bufferline.style_preset.minimal,
        themable = false,
        indicator = { style = "underline" },
        separator_style = "slant",
        -- color_icons = false,
        show_buffer_icons = false, -- disable filetype icons for buffers
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "",
            highlight = "NvimTreeNormal",
            text_align = "left",
            separator = true, -- use a "true" to enable the default, or set your own character
          },
        },
        hover = {
          enabled = true,
          delay = 0,
          reveal = { "close" },
        },
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = ""
          for e in pairs(diagnostics_dict) do
            if e == "error" then
              s = "󰅚"
            end
          end
          return s
        end,
      },
      highlights = {
        fill = { fg = d.text, bg = d.bg2 },
        background = { fg = d.textNC, bg = d.bg, bold = false },
        buffer_selected = {
          fg = d.text,
          bg = d.normal,
          sp = indicator_color,
          underline = true,
          bold = true,
          italic = false,
        },
        buffer_visible = { fg = d.text2, bg = d.normal },
        close_button_selected = { fg = d.text, bg = d.normal, sp = indicator_color, underline = true },
        close_button_visible = { fg = d.text2, bg = d.normal },
        close_button = { fg = d.textNC, bg = d.bg },
        modified_selected = {
          fg = d.text,
          bg = d.normal,
          sp = indicator_color,
          underline = true,
          bold = true,
        },
        modified_visible = { fg = d.text2, bg = d.normal },
        modified = { fg = d.textNC, bg = d.bg },
        duplicate_selected = {
          fg = d.textAlt,
          bg = d.normal,
          sp = indicator_color,
          underline = true,
          bold = false,
          italic = true,
        },
        duplicate_visible = { fg = d.text2Alt, bg = d.normal, bold = false, italic = true },
        duplicate = { fg = d.textNCAlt, bg = d.bg, bold = false, italic = true },
        indicator_selected = { bg = d.normal, sp = indicator_color },
        indicator_visible = { bg = d.normal },
        separator_visible = { fg = d.bg2, bg = d.normal },
        separator_selected = { fg = d.bg2, bg = d.normal, sp = indicator_color, underline = true },
        separator = { fg = d.bg2, bg = d.bg },
        offset_separator = {
          fg = d.bg,
          bg = d.bg,
        },
        error_selected = {
          fg = d.text,
          bg = d.normal,
          sp = indicator_color,
          underline = true,
          bold = true,
          italic = false,
        },
        error_visible = { fg = d.text2, bg = d.normal },
        error = { fg = d.textNC, bg = d.bg },
        warning_selected = {
          fg = d.text,
          bg = d.normal,
          sp = indicator_color,
          underline = true,
          bold = true,
          italic = false,
        },
        warning_visible = { fg = d.text2, bg = d.normal },
        warning = { fg = d.textNC, bg = d.bg },
        hint_selected = {
          fg = d.text,
          bg = d.normal,
          sp = indicator_color,
          underline = true,
          bold = true,
          italic = false,
        },
        hint_visible = { fg = d.text2, bg = d.normal },
        hint = { fg = d.textNC, bg = d.bg },
        info_selected = {
          fg = d.text,
          bg = d.normal,
          sp = indicator_color,
          underline = true,
          bold = true,
          italic = false,
        },
        info_visible = { fg = d.text2, bg = d.normal },
        info = { fg = d.textNC, bg = d.bg },
        error_diagnostic_selected = {
          fg = d.diag_error,
          bg = d.normal,
          underline = true,
          sp = indicator_color,
        },
        error_diagnostic_visible = {
          fg = d.diag_error,
          bg = d.normal,
        },
        error_diagnostic = {
          fg = d.diag_error,
          bg = d.bg,
        },
      },
    })
  end,
}
