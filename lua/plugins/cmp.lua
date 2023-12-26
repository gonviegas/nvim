return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "onsails/lspkind.nvim",
    "rafamadriz/friendly-snippets",
    "Exafunction/codeium.nvim",
    -- "tzachar/cmp-tabnine",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    local has_words_before = function()
      unpack = unpack or table.unpack
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.scroll_docs(-4),
        ["<C-j>"] = cmp.mapping.scroll_docs(4),
        ["<S-z>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.close()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-Space>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.close()
          elseif not cmp.visible() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior,
          select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if not cmp.visible() then
            cmp.complete()
          elseif cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "codeium", max_item_count = 3 },
        -- { name = "cmp_tabnine", max_item_count = 3 },
        { name = "buffer", max_item_count = 3 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }),
      window = {
        completion = {
          winhighlight = "Normal:Float,FloatBorder:FloatBorder,Search:None",
          col_offset = 1,
          side_padding = 0,
          border = "rounded",
        },
        documentation = {
          winhighlight = "Normal:Float,FloatBorder:FloatBorder,Search:None",
          border = "rounded",
        },
      },
      formatting = {
        fields = { "abbr", "kind" },
        format = function(entry, vim_item)
          local maxwidth = 50
          vim_item.abbr = "  " .. string.sub(vim_item.abbr, 1, maxwidth)

          local kind = lspkind.cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = "  " .. (strings[1] or "") .. "  " .. (strings[2] or "")

          if entry.source.name == "buffer" then
            vim_item.kind = "  " .. "β" .. "  " .. "Buffer"
          end

          if entry.source.name == "codeium" then
            vim_item.kind = "  " .. "{}" .. " " .. "Codeium"
          end

          -- if entry.source.name == "cmp_tabnine" then
          --   local detail = (entry.completion_item.data or {}).detail
          --   if detail and detail:find(".*%%.*") then
          --     vim_item.kind = "  " .. "🧿" .. " " .. detail
          --   else
          --     vim_item.kind = "  " .. "🧿" .. " " .. "Tabnine"
          --   end
          -- end

          return vim_item
        end,
      },
      experimental = {
        ghost_text = false,
      },
    })

    -- Turn on Snippets and config
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip").filetype_extend("svelte", { "html" })
    require("luasnip").filetype_extend("javascriptreact", { "html" })
    -- require("luasnip").filetype_extend("typescriptreact", { "html" })

    -- The line beneath this is called `modeline`. See `:help modeline`
    -- vim: ts=2 sts=2 sw=2 et
  end,
}
