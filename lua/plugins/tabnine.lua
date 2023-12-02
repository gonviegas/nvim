return {
  "tzachar/cmp-tabnine",
  enabled = false,
  build = "./install.sh",
  dependencies = "hrsh7th/nvim-cmp",
  config = function()
    require("cmp_tabnine.config"):setup({
      max_lines = 100,
      max_num_results = 3,
      sort = true,
      run_on_every_keystroke = false,
      snippet_placeholder = "...",
      ignored_file_types = {
        -- default is not to ignore
        -- uncomment to ignore in lua:
        -- lua = true
      },
      show_prediction_strength = false,
    })
  end,
}
