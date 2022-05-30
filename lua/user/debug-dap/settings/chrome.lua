local dap = require 'dap'

dap.adapters.chrome = {
  type = "executable",
  command = "node",
  args = { "/home/gabriel/.config/nvim/config-debug/microsoft/vscode-chrome-debug/out/src/chromeDebug.js" } -- TODO adjust
}

local config = {
    type = "chrome",
    request = "attach",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    webRoot = "${workspaceFolder}",
    skipFiles = { "<node_internals>/**/*.js" },
  }

dap.configurations.javascriptreact = { config } -- change this to javascript if needed
-- dap.configurations.javascript = { config } -- change this to javascript if needed

dap.configurations.typescriptreact = { config } -- change to typescript if needed
-- dap.configurations.typescript = { config } -- change to typescript if needed
