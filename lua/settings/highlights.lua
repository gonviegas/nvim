local c = require("settings.colors").Color()
local d = require("settings.colors").Default()

vim.cmd('sign define DiagnosticSignError text= texthl=DiagnosticSignError')
vim.cmd('sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn')
vim.cmd('sign define DiagnosticSignHint text= texthl=DiagnosticSignHint')
vim.cmd('sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo')
vim.cmd('hi DiagnosticError guifg=' .. d.diag_error .. ' guibg=NONE')
vim.cmd('hi DiagnosticWarn guifg=' .. d.diag_warn .. ' guibg=NONE')
vim.cmd('hi DiagnosticHint guifg=' .. d.diag_hint .. ' guibg=NONE')
vim.cmd('hi DiagnosticInfo guifg=' .. d.diag_info .. ' guibg=NONE')
vim.cmd('hi DiagnosticVirtualTextError guifg=' .. d.diag_error .. ' guibg=' .. d.diag_error_bg)
vim.cmd('hi DiagnosticVirtualTextWarn guifg=' .. d.diag_warn .. ' guibg=' .. d.diag_warn_bg)
vim.cmd('hi DiagnosticVirtualTextHint guifg=' .. d.diag_hint .. ' guibg=' .. d.diag_hint_bg)
vim.cmd('hi DiagnosticVirtualTextInfo guifg=' .. d.diag_info .. ' guibg=' .. d.diag_info_bg)
vim.cmd('hi DiagnosticUnderlineError guisp=' .. d.diag_error)
vim.cmd('hi DiagnosticUnderlineWarn guisp=' .. d.diag_warn)
vim.cmd('hi DiagnosticUnderlineHint guisp=' .. d.diag_hint)
vim.cmd('hi DiagnosticUnderlineInfo guisp=' .. d.diag_info)

vim.cmd("hi CursorLine guibg=#303030")
vim.cmd("hi SignColumn guibg=none")
vim.cmd("hi GitSignsAdd guifg=" .. d.git_add .. " guibg=none")
vim.cmd("hi GitSignsChange guifg=" .. d.git_change .. " guibg=none")
vim.cmd("hi GitSignsDelete guifg=" .. d.git_del .. " guibg=none")
vim.cmd("hi GitSignsCurrentLineBlame guifg=" .. c.gray6b)

vim.cmd("hi! Normal guibg=" .. d.normal)
vim.cmd("hi! NormalNC guibg=" .. d.normal)
vim.cmd("hi! NormalFloat guibg=" .. d.normal)
vim.cmd("hi! FloatBorder guibg=none guifg=" .. d.text)
vim.cmd("hi! MsgArea guibg=" .. d.normal)
vim.cmd("hi! ModeMsg guibg=" .. d.normal)
vim.cmd("hi! ErrorMsg guibg=" .. d.normal)
vim.cmd("hi! WarningMsg guibg=" .. d.normal)
vim.cmd("hi! VertSplit guibg=none")
vim.cmd("hi! WinSeparator guibg=" .. d.bg .. " guifg=" .. d.bg)
vim.cmd("hi! EndOfBuffer guifg=" .. c.gray .. " guibg=" .. d.normal)

vim.cmd("hi! WinBar guibg=" .. d.bg)
vim.cmd("hi! WinBarNC guibg=" .. d.bg)
vim.cmd("hi! StatusLine guibg=" .. d.bg .. " guifg=" .. d.text .. " gui=none cterm=none")
vim.cmd("hi! StatusLineNC guibg=" .. d.bg .. " guifg=" .. d.textNC .. " gui=none cterm=none")
vim.cmd("hi! TabLine guibg=" .. d.bg)
vim.cmd("hi! TabLineFill cterm=none gui=none guibg=" .. d.bg .. " guifg=" .. d.textNC)

vim.cmd("hi! NvimTreeNormal guibg=" .. d.bg .. " guifg=none")
vim.cmd("hi! NvimTreeNormalNC guibg=" .. d.bg)
vim.cmd("hi! NvimTreeEndOfBuffer guifg=" .. c.gray .. " guibg=" .. d.bg)
vim.cmd("hi! NvimTreeWinSeparator guibg=" .. d.bg)

vim.cmd("hi! Search guifg=#282828 guibg=#fabd2f")

vim.cmd("hi! TreesitterContext gui=bold guibg=#474947")
vim.cmd("hi! TreesitterContextLineNumber gui=bold guifg=" .. d.textNC .. " guibg=#474947")
vim.cmd("hi! TreesitterContextBottom gui=bold guibg=#353735")

vim.cmd("hi! EyelinerPrimary guifg=#ff00ff gui=bold")
vim.cmd("hi! EyelinerSecondary guifg=#00ffff gui=bold")
vim.cmd("hi! TelescopeNormal guibg=none")

vim.cmd("hi! link RenameNormal NormalFloat")
vim.cmd("hi! link SagaBorder FloatBorder")

vim.cmd("hi! IndentBlankLineChar guifg=" .. c.gray2a)
vim.cmd("hi! IndentBlankLineContextChar guifg=#569cd6")

vim.cmd [[
highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080
highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch
highlight! CmpItemKindSnippet guibg=NONE guifg=#fadd2f
highlight! link CmpItemKindInterface CmpItemKindVariable
highlight! link CmpItemKindText CmpItemKindVariable
]]

vim.cmd("hi! FoldColumn guibg=" .. d.normal)
vim.cmd("hi! Folded guibg=#252045")
vim.cmd("hi! UfoFoldedBg guibg=#252045")
