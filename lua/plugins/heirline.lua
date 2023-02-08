return {
  "rebelot/heirline.nvim",
  config = function()
    local heirline = require("heirline")
    local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")

    local c = require("settings.colors").Color()
    local d = require("settings.colors").Default()

    local ViMode = {
      init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()

        if not self.once then
          vim.api.nvim_create_autocmd("ModeChanged", {
            pattern = "*:*o",
            command = 'redrawstatus'
          })
          self.once = true
        end
      end,
      static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
          n = "NORMAL",
          no = "O-PENDING",
          nov = "N?",
          noV = "N?",
          ["no\22"] = "N?",
          niI = "Ni",
          niR = "Nr",
          niV = "Nv",
          nt = "NORMAL",
          v = "VISUAL",
          vs = "Vs",
          V = "V-LINE",
          Vs = "Vs",
          ["\22"] = "V-BLOCK",
          ["\22s"] = "^V",
          s = "SELECT",
          S = "S-LINE",
          ["\19"] = "S-BLOCK",
          i = "INSERT",
          ic = "Ic",
          ix = "Ix",
          R = "REPLACE",
          Rc = "Rc",
          Rx = "Rx",
          Rv = "V-REPLACE",
          Rvc = "Rv",
          Rvx = "Rv",
          c = "COMMAND",
          cv = "Ex",
          r = "...",
          rm = "M",
          ["r?"] = "?",
          ["!"] = "!",
          t = "INSERT",
        },
        mode_colors = {
          n = c.green,
          i = c.blue,
          v = c.pink,
          V = c.pink,
          ["\22"] = c.pink,
          c = c.orange,
          s = c.magenta,
          S = c.magenta,
          ["\19"] = c.magenta,
          R = c.orange,
          r = c.orange,
          ["!"] = c.green,
          t = c.blue,
        }
      },
      provider = function(self)
        return " %2(" .. self.mode_names[self.mode] .. " %)"
      end,
      -- Same goes for the highlight. Now the foreground will change according to the current mode.
      hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { bg = self.mode_colors[mode], bold = true, fg = d.normal }
      end,
      update = {
        "ModeChanged",
      },
    }

    local FileNameBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
    }

    local FileIcon = {
      init = function(self)
        local filename = self.filename
        local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension,
          { default = true })
      end,
      provider = function(self)
        return self.icon and (" " .. self.icon .. " ")
      end,
      hl = function(self)
        return { fg = self.icon_color }
      end
    }

    local FileName = {
      provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ":t")
        if filename == "" then return "[No Name]" end
        if not conditions.width_percent_below(#filename, 0.25) then
          filename = vim.fn.pathshorten(filename)
        end
        return filename
      end,
    }

    local WorkDirLast = {
      provider = function()
        local cwd = vim.fn.getcwd(0)
        local dir_last = vim.fn.fnamemodify(cwd, ":t")
        return "  " .. dir_last .. " "
      end,
    }

    local FilePath = {
      provider = function(self)
        local filepath = vim.fn.fnamemodify(self.filename, ":.:h")
        local filename = vim.fn.fnamemodify(self.filename, ":t")

        if not conditions.width_percent_below(#filepath, 0.25) then
          filepath = vim.fn.pathshorten(filepath)
        end

        if filename == "" then return ""
        else return filepath .. "/"
        end
      end,
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") == ""
        end,
        provider = " ● ",
        hl = { fg = "Red" },
      },
      {
        condition = function()
          return vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= ""
        end,
        provider = " ● ",
        hl = { fg = "White" },
      },
      {
        condition = function()
          return (not vim.bo.modifiable or vim.bo.readonly) and not (vim.bo.modified)
        end,
        provider = "  ",
        hl = { fg = "Orange" },
      },
      {
        condition = function()
          return (not vim.bo.modifiable or vim.bo.readonly) and (vim.bo.modified)
        end,
        provider = "  ",
        hl = { fg = "Red" },
      },
      {
        condition = function()
          return not vim.bo.modified and not vim.bo.readonly
        end,
        provider = "   ",
      }
    }

    local FileType = {
      provider = function()
        return vim.bo.filetype
      end,
      hl = { fg = d.text, bold = true },
    }

    local Git = {
      condition = conditions.is_git_repo,

      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or
            self.status_dict.changed ~= 0
      end,

      hl = { bg = c.gray4b },


      { -- git branch name
        provider = function(self)
          return "  " .. self.status_dict.head .. " "
        end,
        hl = { fg = d.text, bold = true }
      },
      -- You could handle delimiters, icons and counts similar to Diagnostics
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = ""
      },
      {
        provider = function(self)
          local count = self.status_dict.added or 0
          return count > 0 and ("+" .. count) .. " "
        end,
        hl = { fg = d.git_add },
      },
      {
        provider = function(self)
          local count = self.status_dict.removed or 0
          return count > 0 and ("-" .. count) .. " "
        end,
        hl = { fg = d.git_del },
      },
      {
        provider = function(self)
          local count = self.status_dict.changed or 0
          return count > 0 and ("~" .. count) .. " "
        end,
        hl = { fg = d.git_change },
      },
      {
        condition = function(self)
          return self.has_changes
        end,
        provider = "",
      },
    }

    local Navic = {
      condition = function() return require("nvim-navic").is_available() end,
      static = {
        -- create a type highlight map
        type_hl = {
          File = "Directory",
          Module = "@include",
          Namespace = "@namespace",
          Package = "@include",
          Class = "@structure",
          Method = "@method",
          Property = "@property",
          Field = "@field",
          Constructor = "@constructor",
          Enum = "@field",
          Interface = "@type",
          Function = "@function",
          Variable = "@variable",
          Constant = "@constant",
          String = "@string",
          Number = "@number",
          Boolean = "@boolean",
          Array = "@field",
          Object = "@type",
          Key = "@keyword",
          Null = "@comment",
          EnumMember = "@field",
          Struct = "@structure",
          Event = "@keyword",
          Operator = "@operator",
          TypeParameter = "@type",
        },
        -- bit operation dark magic, see below...
        enc = function(line, col, winnr)
          return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
        end,
        -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
        dec = function(e)
          local line = bit.rshift(e, 16)
          local col = bit.band(bit.rshift(e, 6), 1023)
          local winnr = bit.band(e, 63)
          return line, col, winnr
        end
      },
      init = function(self)
        local data = require("nvim-navic").get_data() or {}
        local children = {}
        -- create a child for each level
        for i, e in ipairs(data) do
          -- encode line and column numbers into a single integer
          local pos = self.enc(e.scope.start.line, e.scope.start.character, self.winnr)
          local child = {
            {
              provider = e.icon,
              hl = self.type_hl[e.type],
            },
            {
              -- escape `%`s (elixir) and buggy default separators
              provider = e.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ''),
              -- highlight icon only or location name as well
              -- hl = self.type_hl[e.type],

              on_click = {
                -- pass the encoded position through minwid
                minwid = pos,
                callback = function(_, minwid)
                  -- decode
                  local line, col, winnr = self.dec(minwid)
                  vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
                end,
                name = "heirline_navic",
              },
            },
          }
          -- add a separator only if needed
          if #data > 1 and i < #data then
            table.insert(child, {
              provider = " > ",
              hl = { fg = 'gray' },
            })
          end
          table.insert(children, child)
        end
        -- instantiate the new child, overwriting the previous one
        self.child = self:new(children, 1)
      end,
      -- evaluate the children containing navic components
      provider = function(self)
        return self.child:eval()
      end,
      hl = { fg = d.text2 },
      update = 'CursorMoved'
    }


    local NavicInactive = {
      condition = function() return require("nvim-navic").is_available() end,
      static = {
        -- create a type highlight map
        type_hl = {
          File = "Directory",
          Module = "@include",
          Namespace = "@namespace",
          Package = "@include",
          Class = "@structure",
          Method = "@method",
          Property = "@property",
          Field = "@field",
          Constructor = "@constructor",
          Enum = "@field",
          Interface = "@type",
          Function = "@function",
          Variable = "@variable",
          Constant = "@constant",
          String = "@string",
          Number = "@number",
          Boolean = "@boolean",
          Array = "@field",
          Object = "@type",
          Key = "@keyword",
          Null = "@comment",
          EnumMember = "@field",
          Struct = "@structure",
          Event = "@keyword",
          Operator = "@operator",
          TypeParameter = "@type",
        },
        -- bit operation dark magic, see below...
        enc = function(line, col, winnr)
          return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
        end,
        -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
        dec = function(e)
          local line = bit.rshift(e, 16)
          local col = bit.band(bit.rshift(e, 6), 1023)
          local winnr = bit.band(e, 63)
          return line, col, winnr
        end
      },
      init = function(self)
        local data = require("nvim-navic").get_data() or {}
        local children = {}
        -- create a child for each level
        for i, e in ipairs(data) do
          -- encode line and column numbers into a single integer
          local pos = self.enc(e.scope.start.line, e.scope.start.character, self.winnr)
          local child = {
            {
              provider = e.icon,
              hl = self.type_hl[e.type],
            },
            {
              -- escape `%`s (elixir) and buggy default separators
              provider = e.name:gsub("%%", "%%%%"):gsub("%s*->%s*", ''),
              -- highlight icon only or location name as well
              -- hl = self.type_hl[e.type],

              on_click = {
                -- pass the encoded position through minwid
                minwid = pos,
                callback = function(_, minwid)
                  -- decode
                  local line, col, winnr = self.dec(minwid)
                  vim.api.nvim_win_set_cursor(vim.fn.win_getid(winnr), { line, col })
                end,
                name = "heirline_navic",
              },
            },
          }
          -- add a separator only if needed
          if #data > 1 and i < #data then
            table.insert(child, {
              provider = " > ",
              hl = { fg = 'gray' },
            })
          end
          table.insert(children, child)
        end
        -- instantiate the new child, overwriting the previous one
        self.child = self:new(children, 1)
      end,
      -- evaluate the children containing navic components
      provider = function(self)
        return self.child:eval()
      end,
      hl = { fg = d.textNC },
      update = 'CursorMoved'
    }

    local FileTypeBlock = utils.insert(FileNameBlock,
      utils.insert(utils.surround({ "", "" }, d.normal2, FileIcon)),
      --utils.insert(FileIcon),
      --utils.insert(FileType)
      utils.insert(utils.surround({ "", "" }, d.normal2, FileType)),
      { provider = " ", hl = { bg = d.normal2 } }
    )

    local FileTypeBlockInactive = utils.insert(FileNameBlock,
      utils.insert(FileIcon),
      utils.insert(utils.surround({ "", "" }, d.bg,
        { hl = { fg = d.textNC, force = true }, FileType }))
    )

    local Diagnostics = {
      condition = conditions.has_diagnostics,

      static = {
        error_icon = "",
        warn_icon = "",
        info_icon = "",
        hint_icon = "",
      },

      init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,

      update = { "DiagnosticChanged", "BufEnter" },

      {
        provider = " ",
      },
      {
        provider = function(self)
          -- 0 is just another output, we can decide to print it or not!
          return self.errors > 0 and (self.error_icon .. " " .. self.errors .. " ")
        end,
        hl = { fg = d.diag_error, bold = true },
      },
      {
        provider = function(self)
          return self.warnings > 0 and (self.warn_icon .. " " .. self.warnings .. " ")
        end,
        hl = { fg = d.diag_warn, bold = true },
      },
      {
        provider = function(self)
          return self.hints > 0 and (self.hint_icon .. " " .. self.hints)
        end,
        hl = { fg = d.diag_hint, bold = true },
      },
      {
        provider = function(self)
          return self.info > 0 and (self.info_icon .. " " .. self.info .. " ")
        end,
        hl = { fg = d.diag_info, bold = true },
      },
      {
        provider = " ",
      },
    }

    local Ruler = {
      init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()

      end,
      static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
          n = "NORMAL",
          no = "O-PENDING",
          nov = "N?",
          noV = "N?",
          ["no\22"] = "N?",
          niI = "Ni",
          niR = "Nr",
          niV = "Nv",
          nt = "Nt",
          v = "VISUAL",
          vs = "Vs",
          V = "V-LINE",
          Vs = "Vs",
          ["\22"] = "V-BLOCK",
          ["\22s"] = "^V",
          s = "SELECT",
          S = "S-LINE",
          ["\19"] = "S-BLOCK",
          i = "INSERT",
          ic = "Ic",
          ix = "Ix",
          R = "REPLACE",
          Rc = "Rc",
          Rx = "Rx",
          Rv = "V-REPLACE",
          Rvc = "Rv",
          Rvx = "Rv",
          c = "COMMAND",
          cv = "Ex",
          r = "...",
          rm = "M",
          ["r?"] = "?",
          ["!"] = "!",
          t = "T",
        },
        mode_colors = {
          n = c.green,
          i = c.blue,
          v = c.pink,
          V = c.pink,
          ["\22"] = c.pink,
          c = c.orange,
          s = c.magenta,
          S = c.magenta,
          ["\19"] = c.magenta,
          R = c.orange,
          r = c.orange,
          ["!"] = c.green,
          t = c.green,
        }
      },
      provider = " %2c:%2l/%L ",
      hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { bg = self.mode_colors[mode], bold = true, fg = d.bg }
      end,
      update = {
        "ModeChanged",
      },
    }

    local Scroll = {
      provider = function()
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * 100) + 1
        if (curr_line == 1) then
          return " top "
        elseif (curr_line == lines) then
          return " bot "
        else
          return " " .. i .. "%% "
        end
      end,
      hl = { fg = d.text, bg = c.gray4b },
    }

    local LSPActive = {
      condition = conditions.lsp_attached,
      update = { 'LspAttach', 'LspDetach' },

      {
        provider = " ",
        hl = { fg = c.green, bold = true },
      },
      {
        provider = function()
          local names = {}
          for i, server in pairs(vim.lsp.get_active_clients()) do
            table.insert(names, server.name)
          end
          return table.concat(names, ", ")
        end,
        hl = { fg = c.green, bold = false },
      },
      {
        provider = " ",
        hl = { fg = d.normal2, bold = true },
      }
    }

    local WorkDir = {
      provider = function()
        local cwd = vim.fn.getcwd(0)
        cwd = vim.fn.fnamemodify(cwd, ":~")
        return " " .. cwd .. " "
      end,
    }

    local Align = { provider = "%=" }

    local DefaultStatusline = {
      hl = { bg = d.bg },
      fallthrough = false,
      {
        condition = function()
          return conditions.is_active()
        end,
        { flexible = 20, ViMode, { provider = "" } },
        { flexible = 10, Git, { provider = "" } },
        { flexible = 15, Diagnostics, { provider = "" } },
        Align,
        { flexible = 2, LSPActive, { provider = "" } },
        { flexible = 8, FileTypeBlock, { provider = "" } },
        { flexible = 9, Scroll, { provider = "" } },
        { flexible = 21, Ruler, { provider = "" } }
      },
      {
        condition = function()
          return not conditions.is_active()
        end,
        { flexible = 10, FileTypeBlockInactive, { provider = "" } },
        Align,
        { flexible = 20,
          utils.surround({ "", "" }, c.gray3b,
            { hl = { fg = d.textNC, force = true }, Ruler }),
          { provider = "" }
        },
      }
    }

    local NvimTreeStatusline = {
      condition = function()
        return conditions.buffer_matches({ filetype = { "NvimTree" } })
      end,

      hl = { bg = d.bg },

      fallthrough = false,
      {
        condition = function()
          return conditions.is_active()
        end,
        utils.surround({ "", "" }, c.green,
          { hl = { fg = d.bg, bold = true, force = true }, WorkDir }),
        Align,
      },
      {
        condition = function()
          return not conditions.is_active()
        end,
        utils.surround({ "", "" }, d.bg, { hl = { fg = d.textNC, force = true }, WorkDir }),
        Align,
      }
    }

    local TerminalStatusLine = {
      condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
      end,
      hl = { bg = d.bg },

      fallthrough = false,
      {
        condition = function()
          return conditions.is_active()

        end,
        ViMode,
        Align,
      },
      {
        condition = function()
          return not conditions.is_active()
        end,
      }
    }

    local SpecialStatusline = {
      condition = function()
        return conditions.buffer_matches({
          buftype = { "nofile", "prompt", "help", "quickfix" },
          filetype = { "fugitive" },
        })
      end,

    }

    local statusline = {
      hl = function()
        if conditions.is_active() then
          return { fg = utils.get_highlight('StatusLine').fg, bg = utils.get_highlight('StatusLine').bg }
        else
          return { fg = utils.get_highlight('StatusLineNC').fg, bg = utils.get_highlight('StatusLineNC').bg }
        end
      end,

      fallthrough = false,

      NvimTreeStatusline, TerminalStatusLine, SpecialStatusline, DefaultStatusline,
    }

    local TerminalName = {
      provider = function()
        local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*toggleterm#", "")
        return " " .. " Terminal " .. tname
      end,
    }

    local TerminalNameBlockActive = utils.insert(FileNameBlock,
      utils.insert(utils.surround({ "", "" }, c.dark_blue,
        { hl = { fg = d.text, bold = true }, TerminalName })),
      { provider = " ", hl = { bg = c.dark_blue } },
      { provider = "", hl = { fg = c.dark_blue, bg = d.bg } },
      { provider = " ", hl = { bg = d.bg } }
    )

    local TerminalNameBlockInactive = utils.insert(FileNameBlock,
      utils.insert(utils.surround({ "", "" }, c.gray3b,
        { hl = { fg = d.textNC, bold = true }, TerminalName })),
      { provider = " ", hl = { bg = c.gray3b } },
      { provider = "", hl = { fg = c.gray3b, bg = d.bg } },
      { provider = " ", hl = { bg = d.bg } }
    )

    local FileNameBlockActive = utils.insert(FileNameBlock,
      utils.insert(utils.surround({ "", "" }, c.dark_blue, FileIcon)),
      utils.insert(utils.surround({ "", "" }, c.dark_blue,
        { hl = { fg = d.text2, bold = false, italic = true }, FilePath })),
      utils.insert(utils.surround({ "", "" }, c.dark_blue,
        { hl = { fg = d.text, bold = true }, FileName })),
      { provider = " ", hl = { bg = c.dark_blue } },
      { provider = "", hl = { fg = c.dark_blue, bg = d.bg } },
      { provider = " ", hl = { bg = d.bg } }
    )

    local FileNameBlockInactive = utils.insert(FileNameBlock,
      utils.insert(utils.surround({ "", "" }, c.gray3b, FileIcon)),
      utils.insert(utils.surround({ "", "" }, c.gray3b,
        { hl = { fg = d.textNC, bold = false, italic = true }, FilePath })),
      utils.insert(utils.surround({ "", "" }, c.gray3b,
        { hl = { fg = d.textNC, bold = true }, FileName })),
      { provider = " ", hl = { bg = c.gray3b } },
      { provider = "", hl = { fg = c.gray3b, bg = d.bg } },
      { provider = " ", hl = { bg = d.bg } }
    )

    local FileFlagsBlock = utils.insert(FileFlags)

    local NavicBlock = utils.insert(Navic,
      { provider = '%<' }-- this means that the statusline is cut here when there's not enough space
    )

    local NavicInactiveBlock = utils.insert(NavicInactive,
      { provider = '%<' }-- this means that the statusline is cut here when there's not enough space
    )

    local winbar = {
      fallthrough = false,
      {
        condition = function()
          return conditions.buffer_matches({
            filetype = { "NvimTree" },
          })
        end,
        fallthrough = false,
        {
          condition = function()
            return not conditions.is_active()
          end,
          utils.insert(utils.surround({ "", "" }, c.gray3b,
            { hl = { fg = d.textNC, bold = true }, WorkDirLast })),
          { provider = "", hl = { fg = c.gray3b, bg = d.bg } },
        },
        {
          utils.insert(utils.surround({ "", "" }, c.dark_blue,
            { hl = { fg = d.text, bold = true }, WorkDirLast })),
          { provider = "", hl = { fg = c.dark_blue, bg = d.bg } },
        },
      },
      { -- Hide the winbar for special buffers
        condition = function()
          return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "fugitive" },
          })
        end,
        init = function()
          vim.opt_local.winbar = nil
        end
      },
      {
        condition = function()
          return conditions.buffer_matches({
            buftype = { "terminal" },
            filetype = { "toggleterm" },
          })
        end,
        fallthrough = false,
        {
          condition = function()
            return not conditions.is_active()
          end,
          TerminalNameBlockInactive,
        },
        {
          TerminalNameBlockActive,
        },
      },
      { -- An inactive winbar for regular files
        condition = function()
          return not conditions.is_active()
        end,
        utils.surround({ "", "" }, c.gray3b, FileFlagsBlock),
        FileNameBlockInactive,
	      utils.surround({ "", "" }, d.bg, NavicInactiveBlock),
      },
      {
        -- A winbar for regular files
        utils.surround({ "", "" }, c.dark_blue, FileFlagsBlock),
        FileNameBlockActive,
        utils.surround({ "", "" }, d.bg, NavicBlock),
      }
    }

    heirline.setup({
      statusline = statusline,
      winbar = winbar
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = 'HeirlineInitWinbar',
      callback = function(args)
        local buf = args.buf
        local buftype = vim.tbl_contains(
          { "prompt", "nofile", "help", "quickfix", "terminal" },
          vim.bo[buf].buftype
        )
        local filetype = vim.tbl_contains({ "gitcommit", "fugitive", "NvimTree" }, vim.bo[buf].filetype)
        if buftype or filetype then
          vim.opt_local.winbar = nil
        end
      end,
    })
  end
}
