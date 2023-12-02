return {
  {
    "m4xshen/hardtime.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {},
  },
  {
    "lambdalisue/suda.vim",
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig",
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  "kdheepak/lazygit.nvim",

  {
    "numToStr/Comment.nvim",
    lazy = false,
    config = function()
      require("Comment").setup()
      local ft = require("Comment.ft")
      ft.set("javascript", { "//%s", "{/*%s*/}" })
      ft.set("tsx", { "//%s", "{/*%s*/}" })
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = vim.fn.executable("make") == 1,
  },

  "MattesGroeger/vim-bookmarks",

  "mbbill/undotree",

  "stevearc/dressing.nvim",

  "j-morano/buffer_manager.nvim",

  "famiu/bufdelete.nvim",

  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup({})
    end,
  },

  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup({})
    end,
  },

  {
    "napmn/react-extract.nvim",
    config = function()
      require("react-extract").setup({})
    end,
  },
}
