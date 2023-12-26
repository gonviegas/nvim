return {
  "mfussenegger/nvim-dap",
  config = function()
    require("dap").adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
      },
    }

    require("dap").adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "9239",
      executable = {
        command = "js-debug-adapter",
        args = { "9239" },
      },
    }

    require("dap").configurations["javascript"] = {
      {
        name = "Launch",
        type = "pwa-node",
        request = "launch",
        program = "${file}",
        rootPath = "${workspaceFolder}",
        cwd = "${workspaceFolder}",
        sourceMaps = true,
        resolveSourceMapLocations = {
          "${workspaceFolder}/**",
          "!**/node_modules/**",
        },
        skipFiles = { "node_modules/**" },
        protocol = "inspector",
      },
    }

    for _, language in ipairs({ "typescript", "typescriptreact", "javascriptreact" }) do
      require("dap").configurations[language] = {
        {
          name = "Launch",
          type = "pwa-node",
          request = "launch",
          program = "${file}",
          rootPath = "${workspaceFolder}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
          runtimeArgs = { "-r", "ts-node/register", "--inspect" },
          skipFiles = { "node_modules/**" },
          protocol = "inspector",
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = 'Start Chrome with "localhost"',
          url = "http://localhost:5173",
          webRoot = "${workspaceFolder}",
          runtimeExecutable = os.getenv("HOME") .. "/.local/share/flatpak/exports/bin/com.google.Chrome",
          runtimeArgs = {
            "--remote-debugging-port=9239",
          },
        },
      }
    end
    -- Set keymaps to control the debugger
    vim.keymap.set("n", "<F5>", require("dap").continue)
    vim.keymap.set("n", "<F10>", require("dap").step_over)
    vim.keymap.set("n", "<F11>", require("dap").step_into)
    vim.keymap.set("n", "<F12>", require("dap").step_out)
    vim.keymap.set("n", "<leader>b", require("dap").toggle_breakpoint)
    vim.keymap.set("n", "<leader>B", function()
      require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end)
  end,
}
