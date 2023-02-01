-- Lazy install if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load before Lazy
vim.o.termguicolors = true
vim.g.mapleader = ','
vim.g.maplocalleader = ' '

-- Load Lazy
require("lazy").setup('plugins', {
  ui = {
    wrap = false,
    border = "rounded",
  },
})

-- Load settings folder
for _, file in ipairs(vim.fn.readdir(vim.fn.stdpath('config') .. '/lua/settings', [[v:val =~ '\.lua$']])) do
  require('settings.' .. file:gsub('%.lua$', ''))
end
