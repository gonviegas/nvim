return {
  { "lunarvim/darkplus.nvim",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme darkplus")
    end
  },

  { "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig"
  },

  { 'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup {}
    end
  },

  'kdheepak/lazygit.nvim',

  { 'numToStr/Comment.nvim',
    config = function()
      require("Comment").setup()
    end
  },

  { "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]()
    end
  },

  { 'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    cond = vim.fn.executable 'make' == 1
  },

  'MattesGroeger/vim-bookmarks',

  'mbbill/undotree',

  'stevearc/dressing.nvim',

  'j-morano/buffer_manager.nvim',
  'famiu/bufdelete.nvim',

  { "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end
  },

  { 'simrat39/symbols-outline.nvim',
    config = function()
      require("symbols-outline").setup({
      })
    end
  },

  { "jcdickinson/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim"
    },
    config = function()
      require("codeium").setup({
      })
    end
  },

  { "napmn/react-extract.nvim",
    config = function()
      require("react-extract").setup({
      })
    end
  },
}
