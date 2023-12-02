return {
  "natecraddock/workspaces.nvim",
  config = function()
    function NvimTreeOpen()
      local nvimtree = require("nvim-tree")
      local nvimtree_view = require("nvim-tree.view")

      if nvimtree_view.is_visible() then
        nvimtree.toggle()
        vim.cmd("NvimTreeOpen .")
      else
        vim.cmd("NvimTreeOpen .")
      end
    end

    require("workspaces").setup({
      hooks = {
        open = NvimTreeOpen,
      },
    })
  end,
}
