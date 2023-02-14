return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'j-hui/fidget.nvim',
    'folke/neodev.nvim',
  },
  config = function()
    vim.diagnostic.config({
      update_in_insert = true,
      virtual_text = {
        prefix = '●',
        source = "if_many"
      },
    })

    local max_width = math.max(math.floor(vim.o.columns * 0.7), 100)
    local max_height = math.max(math.floor(vim.o.lines * 0.3), 30)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = 'rounded',
      max_width = max_width,
      max_height = max_height,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
      border = 'rounded',
      max_width = max_width,
      max_height = max_height,
    })

    local on_attach = function(_, bufnr)
      local navic = require("nvim-navic")

      if _.server_capabilities.documentSymbolProvider then
        navic.attach(_, bufnr)
      end

    end

    local servers = {
      bashls = {},
      astro = {},
      clangd = {},
      cssls = {},
      cssmodules_ls = {},
      html = {},
      jsonls = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      marksman = {},
      svelte = {},
      tailwindcss = {},
      tsserver = {},
    }

    require('neodev').setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    require('mason').setup({
      ui = {
        check_outdated_packages_on_open = true,
        border = "rounded",
        icons = {
          package_installed = "🗹",
          package_pending = "🞔",
          package_uninstalled = "□",
        },
      }
    })

    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require("lspconfig")[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
        }
      end,
    }

    require('fidget').setup()
  end
}
