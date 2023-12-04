return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "jay-babu/mason-null-ls.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "j-hui/fidget.nvim",
    "folke/neodev.nvim",
  },
  config = function()
    vim.diagnostic.config({
      update_in_insert = false,
      virtual_text = {
        prefix = "●",
        source = "if_many",
      },
    })

    local max_width = math.max(math.floor(vim.o.columns * 0.7), 100)
    local max_height = math.max(math.floor(vim.o.lines * 0.3), 30)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
      max_width = max_width,
      max_height = max_height,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = "rounded",
      max_width = max_width,
      max_height = max_height,
    })

    local on_attach = function(_, bufnr)
      local navic = require("nvim-navic")

      if _.server_capabilities.documentSymbolProvider then
        navic.attach(_, bufnr)
      end

      local lsp_formatting = function(bufnr)
        vim.lsp.buf.format({
          filter = function(client)
            -- apply whatever logic you want (in this example, we'll only use null-ls)
            return client.name == "null-ls"
          end,
          bufnr = bufnr,
        })
      end

      -- if you want to set up formatting on save, you can use this as a callback
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

      -- add to your shared on_attach callback
      if _.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            lsp_formatting(bufnr)
          end,
        })
      end
    end

    require("neodev").setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local servers = {
      astro = {},
      bashls = {},
      clangd = {},
      cssls = {},
      graphql = {},
      html = {},
      jsonls = {},
      lua_ls = {
        settings = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
      marksman = {},
      prismals = {},
      svelte = {},
      tailwindcss = {},
      tsserver = {},
      yamlls = {},
      eslint = {},
    }

    local linters_and_formatters = {
      "prettierd",
      "stylua",
      "beautysh",
    }

    local flags = {
      debounce_text_changes = 500,
      throttle = 550,
      fetching_timeout = 80,
    }

    require("mason").setup({
      ui = {
        check_outdated_packages_on_open = true,
        border = "rounded",
        icons = {
          package_installed = "☑",
          package_pending = "⌛",
          package_uninstalled = "□",
        },
      },
    })

    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.beautysh.with({
          command = "beautysh",
          args = {
            "--indent-size",
            "2",
            "$FILENAME",
          },
        }),
        null_ls.builtins.formatting.stylua.with({
          extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/lua/utils/stylua.toml") },
        }),
        null_ls.builtins.formatting.prettierd.with({
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/lua/utils/prettierrc.json"),
          },
          extra_filetypes = { "astro", "markdown" },
        }),
      },
    })

    require("mason-null-ls").setup({
      ensure_installed = linters_and_formatters,
      automatic_installation = false,
    })

    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          flags = flags,
        })
      end,
    })

    require("fidget").setup()
  end,
}
