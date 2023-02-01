local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  callback = function()
    if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
      vim.api.nvim_command('silent update')
    end
  end,
})

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.cmd("luafile ~/.config/nvim/lua/plugins/heirline.lua")
    vim.cmd("luafile ~/.config/nvim/lua/settings/highlights.lua")
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.bo.filetype == "toggleterm" or vim.bo.buftype == "terminal" or vim.bo.filetype == "NvimTree" then
      vim.cmd("set winbar=%{%v:lua.require'heirline'.eval_winbar()%}")
    end
  end,
})

vim.cmd('autocmd VimEnter * silent !set-nvim-icon') --set nvim icon when entering nvim
