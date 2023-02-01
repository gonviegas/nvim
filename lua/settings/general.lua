-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = false

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true
vim.o.smartindent = true
-- vim.o.smarttab = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.cursorline = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Set colorscheme
-- vim.o.background = "dark" -- or "light" for light mode

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Nvim Tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.hidden = true

vim.opt.modelineexpr = true
vim.cmd("set clipboard+=unnamedplus")

vim.opt.fillchars = {
  --fold = " ", -- remove folding chars
  vert = " ", -- set vsplit chars
}
vim.opt.list = true
-- vim.opt.listchars:append "space:·"
-- vim.opt.listchars:append "eol:↴"

vim.cmd("set whichwrap+=<,>,h,l")

vim.cmd("let g:bookmark_no_default_key_mappings = 1")

vim.o.pumheight = 15

vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.cmd[[set fillchars=eob:\ ,fold:\ ,foldopen:,foldsep:\ ,foldclose:⯈]]
