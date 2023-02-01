local status, mapper = pcall(require, "nvim-mapper")
if (not status) then
  return
end

local map = mapper.map
local opts = { noremap = true, silent = true }

-- local c = require("settings.colors").Color()
local d = require("settings.colors").Default()

local function SetBgColor()
  vim.cmd('hi! Normal guibg=' .. d.normal)
  vim.cmd('hi! NormalNC guibg=' .. d.normal)
  vim.cmd('hi! NormalFloat guibg=' .. d.normal)
  vim.cmd('hi! EndOfBuffer guibg=' .. d.normal)
end

local function RemoveBgColor()
  vim.cmd('hi! Normal guibg=none')
  vim.cmd('hi! NormalNC guibg=none')
  vim.cmd('hi! NormalFloat guibg=none')
  vim.cmd('hi! EndOfBuffer guibg=none')
end

-- GENERAL
map('n', '<leader>c', ':noh<CR>', opts, "GENERAL", "clear_search_highlight", "Clear Search Highlight")
map('n', '<leader>l', ':set number relativenumber!<cr>', opts, "GENERAL", "relativenumber",
  "Toggle relative line numbers")
map('n', '<leader>w', ':set number wrap!<cr>', opts, "GENERAL", "wordwrap", "Toggle word wrap")
map('n', '<A-=>', SetBgColor, opts, "GENERAL", "bg_color_true", "Enable background color")
map('n', '<A-->', RemoveBgColor, opts, "GENERAL", "bg_color_false", "No background color")

-- MAPPER
map('n', '<space>M', '<CMD>Telescope mapper<CR>', opts, "MAPPER", "Telescope mapper", "Show keymaps")

-- NAVIGATION
map('n', '<A-c>', '<C-w>q', opts, "NAVIGATION", "close_window", "Close Window")
map('n', '<A-\\>', ':vsplit<CR>', opts, "NAVIGATION", "vsplit", "Vertical Split Window")
map('n', '<A-|>', ':split<CR>', opts, "NAVIGATION", "split", "Horizontal Split Window")
map('n', '<A-h>', ':wincmd h<CR>', opts, "NAVIGATION", "wincmd_left", "Window Focus Left")
map('n', '<A-l>', ':wincmd l<CR>', opts, "NAVIGATION", "wincmd_right", "Window Focus Right")
map('n', '<A-j>', ':wincmd j<CR>', opts, "NAVIGATION", "wincmd_down", "Window Focus Down")
map('n', '<A-k>', ':wincmd k<CR>', opts, "NAVIGATION", "wincmd_up", "Window Focus Up")
map('n', '<A-C-h>', '4<C-w><', opts, 'NAVIGATION', 'resize_window_left', 'Resize Window Left')
map('n', '<A-C-l>', '4<C-w>>', opts, 'NAVIGATION', 'resize_window_right', 'Resize Window Right')
map('n', '<A-C-j>', '2<C-w>+', opts, 'NAVIGATION', 'resize_window_down', 'Resize Window Down')
map('n', '<A-C-k>', '2<C-w>-', opts, 'NAVIGATION', 'resize_window_up', 'Resize Window Up')
map('n', '<A-S-h>', '<Cmd>WinShift left<CR>', opts, 'NAVIGATION', 'WinShift_Left', 'Resize Window Right')
map('n', '<A-S-l>', '<Cmd>WinShift right<CR>', opts, 'NAVIGATION', 'WinShift_Right', 'Resize Window Right')
map('n', '<A-S-j>', '<Cmd>WinShift down<CR>', opts, 'NAVIGATION', 'WinShift_down', 'Window Move Down')
map('n', '<A-S-k>', '<Cmd>WinShift up<CR>', opts, 'NAVIGATION', 'WinShift_up', 'Window Move Up')
map('n', '<A-S-s>', '<Cmd>WinShift swap<CR>', opts, "NAVIGATION", "WinShift_swap", "Window Swap")
map('n', '<S-j>', '<CMD>m+1<CR>', opts, "NAVIGATION", "Move_Line_Down", "Move Line Down")
map('n', '<S-K>', '<CMD>m-2<CR>', opts, "NAVIGATION", "Move_Line_Up", "Move Line Up")
map('v', '<S-j>', ":m '>+1<CR>gv=gv", opts, "NAVIGATION", "Move_Selected_Lines_Down", "Move Line Down")
map('v', '<S-K>', ":m '<-2<CR>gv=gv", opts, "NAVIGATION", "Move_Selected_Lines_Up", "Move Line Up")

-- BUFFERS
map('n', '<A-space>', ':lua require("buffer_manager.ui").toggle_quick_menu()<CR>', opts, "BUFFERS",
  "buffer_manager.toggle_quick_menuBdelete", "Open buffer list")
map('n', '<A-q>',
  '<CMD>lua require("buffer_manager.ui").nav_prev()<CR>'
  , opts, "BUFFERS", "buffer_manager.nav_prev", "Previous Buffer Focus")
map('n', '<A-w>',
  '<CMD>lua require("buffer_manager.ui").nav_next()<CR>'
  , opts, "BUFFERS", "buffer_manager.nav_next", "Next Buffer Focus")
map('n', '<A-S-c>',
  '<CMD>Bdelete<CR>'
  , opts, "BUFFERS", "Bdelete", "Close current buffer")

-- TREE
map('n', '<space>n', ':NvimTreeToggle<CR>', opts, "EXPLORER", "NvimTreeToggle", "Toggle File Explorer")

-- LSP
map('n', 'g[', ':Lspsaga diagnostic_jump_prev<CR>', opts, "LSP", "diagnostic.goto_prev", "Go to the previous diagnostic")
map('n', 'g]', ':Lspsaga diagnostic_jump_next<CR>', opts, "LSP", "diagnostic.goto_next", "Go to the next diagnostic")
map('n', 'g{', function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end,
  opts, "LSP", "diagnostic.goto_prev_error", "Go to the previous error diagnostic")
map('n', 'g}', function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end,
  opts, "LSP", "diagnostic.goto_next_error", "Go to the next error diagnostic")
map('n', '<space>e', '<CMD>Lspsaga show_line_diagnostics<CR>', opts, "LSP", "diagnostic.open_float",
  "Open diagnostic window")
map('n', '<space>r', "<cmd>Lspsaga rename<CR>", opts, "LSP", "lsp.buf.rename", "[R]e[n]ame all references")
map('n', 'gc', vim.lsp.buf.code_action, opts, "LSP", "lsp.buf.code_action", "[C]ode [A]ction")
map('n', 'gk', '<cmd>Lspsaga hover_doc<CR>', opts, "LSP", "lsp.buf.hover", "Hover Documentation")
map('n', 'g<C-k>', '<cmd>Lspsaga hover_doc ++keep<CR>', opts, "LSP", "lsp.buf.hover_keep", "Hover Documentation")
map('n', 'gK', vim.lsp.buf.signature_help, opts, "LSP", "lsp.buf.signature_help", "Signature Documentation")
map('n', 'gC', vim.lsp.buf.declaration, opts, "LSP", "lsp.buf.declaration", "[G]oto De[C]laration")
map('n', 'gr', ":TroubleToggle lsp_references<CR>", opts, "LSP-TROUBLE", "TroubleToggle_lsp_references",
  "Show references")
map('n', 'gd', ":TroubleToggle lsp_definitions<CR>", opts, "LSP-TROUBLE", "TroubleToggle_lsp_definitions",
  "Show definitions")
map('n', 'gi', ":TroubleToggle lsp_implementations<CR>", opts, "LSP-TROUBLE", "TroubleToggle_lsp_implementations",
  "Show implementations")
map('n', 'gt', ":TroubleToggle lsp_type_definitions<CR>", opts, "LSP-TROUBLE", "TroubleToggle_lsp_type_definitions",
  "Show type definitions")
map('n', '<space>q', ":TroubleToggle document_diagnostics<CR>", opts, "LSP-TROUBLE", "TroubleToggle_document_diagnostics"
  , "Show buffer diagnostics")
map('n', '<space>wq', ":TroubleToggle workspace_diagnostics<CR>", opts, "LSP-TROUBLE",
  "TroubleToggle_workspace_diagnostics", "Show workspace diagnostics")
map('n', '<space>f', vim.lsp.buf.format, opts, "LSP", "lsp.buf.formatting", "[F]ormat code")
map('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, opts, "LSP", "lsp_document_symbols",
  "[D]ocument [S]ymbols")
map('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts, "LSP",
  "lsp_dynamic_workspace_symbols", "[W]orkspace [S]ymbols")

-- ZENMODE
map('n', '<A-f>', ':ZenMode<cr>', opts, "NAVIGATION", "zenmode", "Toggle Zen Mode")

-- TELESCOPE
map('n', '<space>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' }, "TELESCOPE",
  "Telescope_find_files", "[S]earch [F]iles")
map('n', '<space>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' }, "TELESCOPE",
  "Telescope_help_tags", '[S]earch [H]elp')
map('n', '<space>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' }, "TELESCOPE",
  "Telescope_grep_string", '[S]earch current [W]ord')
map('n', '<space>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' }, "TELESCOPE",
  "Telescope_live_grep", '[S]earch by [G]rep')
map('n', '<space>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' }, "TELESCOPE",
  "Telescope_diagnostics", '[S]earch [D]iagnostics')

map('n', '<space>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' }, "TELESCOPE",
  "Telescope_oldfiles", 'Find recently opened files')
map('n', '<space>b', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' }, "TELESCOPE",
  "Telescope_buffers", 'Find existing buffers')
map('n', '<space>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer]' }, "TELESCOPE", "Telescope_current_buffer_fuzzy_find",
  'Fuzzily search in current buffer')

-- LazyGit
map("n", "<space>g", "<cmd>LazyGit<cr>", opts, "LAZYGIT", "LazyGit", "Open Lazy Git")
map("n", "<space>G", "<cmd>LazyGitFilterCurrentFile<cr>", opts, "LAZYGIT", "LazyGit_filter_current_file",
  "Open Lazy Git for selected buffer")

-- MARKDOWN
map("n", "<space>p", "<cmd>MarkdownPreviewToggle<cr>", opts, "MARKDOWN", "Markdown_Preview_Toggle",
  "Markdown Preview Toggle")

-- NEOGEN
map('n', '<space>c', ":lua require('neogen').generate()<CR>", opts, "COMMENT", "neogen_generate",
  "Create new comment on function")

-- TREESITTER CONTEXT
map('n', '<leader>t', ':TSContextToggle<CR>', opts, "TREESITTER", "TSContextToggle", "Toggle Treesitter Context")

-- BOOKMARKS
map('n', '<space>mm', ':BookmarkShowAll<CR>', opts, "BOOKMARKS", "BookmarkShowAll", "Show bookmarks")
map('n', 'mm', ':BookmarkToggle<CR>', opts, "BOOKMARKS", "BookmarkToggle", "Add/remove bookmark at current line")
map('n', 'm]', ':BookmarkNext<CR>', opts, "BOOKMARKS", "BookmarkNext", "Go to next bookmark")
map('n', 'm[', ':BookmarkPrev<CR>', opts, "BOOKMARKS", "BookmarkPrev", "Go to previous bookmark")
map('n', 'ma', ':BookmarkAnnotate<CR>', opts, "BOOKMARKS", "BookmarkAnnotate", "Add/edit/remove annotation")
map('n', 'mc', ':BookmarkClear<CR>', opts, "BOOKMARKS", "BookmarkClear", "Clear bookmarks in current buffer")
map('n', 'mx', ':BookmarkClearAll<CR>', opts, "BOOKMARKS", "BookmarkClearAll", "Clear bookmarks in all buffers")

-- UNDOTREE
map('n', '<space>u', function()
  local nvimtree = require "nvim-tree"
  local nvimtree_view = require "nvim-tree.view"

  if nvimtree_view.is_visible() then
    nvimtree.toggle()
    vim.cmd("UndotreeToggle")
    nvimtree.toggle(false, true)
    vim.cmd("UndotreeFocus")
    vim.cmd("hi TabLineFill cterm=none gui=none guibg=" .. d.bg .. " guifg=" .. d.textNC)
  else
    vim.cmd("UndotreeToggle")
    vim.cmd("UndotreeFocus")
  end

  if vim.bo.filetype == "undotree" then
    vim.cmd("vert resize 50")
  end

end, opts, "UNDOTREE", "UndotreeToggle", "Toggle Undotree")

-- WORKSPACES
map('n', '<space>ww', ":Telescope workspaces<CR>", opts, "WORKSPACES", "WorkspacesOpen", "Open Workspace")
map('n', '<space>wa', ":WorkspacesAdd<CR>", opts, "WORKSPACES", "WorkspacesAdd", "Add Workspace")
map('n', '<space>wd', ":WorkspacesRemove<CR>", opts, "WORKSPACES", "WorkspacesRemove", "Remove Workspace")

-- REACT EXTRACT
map({ "v" }, "<Leader>re", require("react-extract").extract_to_new_file, opts, "REACT-EXTRACT", "React_Extract_New_File", "React Extract to new file")
map({ "v" }, "<Leader>rc", require("react-extract").extract_to_current_file, opts, "REACT-EXTRACT", "React_Extract_Current_File", "React Extract to current file")

-- REACT EXTRACT
map({ "n" }, "go", ':SymbolsOutline<CR>', opts, "SYMBOLS-OUTLINE", "Symbols_Outline_Toggle", "Toggle Symbols Outline")

-- TERMINAL
map('n', '<space>t', ':ToggleTerm<CR>', opts, "TERMINAL", "terminal_toggle", "Toggle Terminal")
map('n', '<space>1t', ':ToggleTerm 1<CR>', opts, "TERMINAL", "terminal_1_toggle", "Toggle Terminal 1")
map('n', '<space>2t', ':ToggleTerm 2<CR>', opts, "TERMINAL", "terminal_2_toggle", "Toggle Terminal 2")
map('n', '<space>3t', ':ToggleTerm 3<CR>', opts, "TERMINAL", "terminal_3_toggle", "Toggle Terminal 3")

function _G.set_terminal_keymaps()
  local nobufopts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], nobufopts)
  vim.keymap.set('t', '<A-k>', [[<C-\><C-n> | <Cmd>wincmd k<CR>]], nobufopts)
  vim.keymap.set('t', '<A-j>', [[<C-\><C-n> | <Cmd>wincmd j<CR>]], nobufopts)
  vim.keymap.set('t', '<A-h>', [[<C-\><C-n> | <Cmd>wincmd h<CR>]], nobufopts)
  vim.keymap.set('t', '<A-l>', [[<C-\><C-n> | <Cmd>wincmd l<CR>]], nobufopts)
  vim.keymap.set('t', '<A-C-h>', [[<C-\><C-n> | 4<C-w><<CR> | :startinsert<CR>]], nobufopts)
  vim.keymap.set('t', '<A-C-l>', [[<C-\><C-n> | 4<C-w>><CR> | :startinsert<CR>]], nobufopts)
  vim.keymap.set('t', '<A-C-j>', [[<C-\><C-n> | 2<C-w>+<CR> | :startinsert<CR>]], nobufopts)
  vim.keymap.set('t', '<A-C-k>', [[<C-\><C-n> | 2<C-w>-<CR> | :startinsert<CR>]], nobufopts)
  vim.keymap.set('t', '<A-S-h>', [[<C-\><C-n> | <Cmd>WinShift left<CR><Cmd>startinsert<CR>]], nobufopts)
  vim.keymap.set('t', '<A-S-l>', [[<C-\><C-n> | <Cmd>WinShift right<CR><Cmd>startinsert<CR>]], nobufopts)
  vim.keymap.set('t', '<A-S-j>', [[<C-\><C-n> | <Cmd>WinShift down<CR><Cmd>startinsert<CR>]], nobufopts)
  vim.keymap.set('t', '<A-S-k>', [[<C-\><C-n> | <Cmd>WinShift up<CR><Cmd>startinsert<CR>]], nobufopts)
end

vim.cmd('autocmd! TermOpen term://*toggleterm#* lua set_terminal_keymaps()')
vim.cmd('autocmd TermOpen term://* startinsert')

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
