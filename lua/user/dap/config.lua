require("mason-nvim-dap").setup({
   handlers = {},
})

local dap, dapui = require("dap"), require("dapui")
dapui.setup({})
dap.listeners.after.event_initialized["dapui_config"] = function()
   dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
   dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
   dapui.close()
end

vim.fn.sign_define(
   "DapBreakpoint",
   {
      text = "",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
   }
)
vim.fn.sign_define(
   "DapBreakpointCondition",
   {
      text = "ﳁ",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
   }
)
vim.fn.sign_define(
   "DapBreakpointRejected",
   {
      text = "",
      texthl = "DapBreakpoint",
      linehl = "DapBreakpoint",
      numhl = "DapBreakpoint",
   }
)
vim.fn.sign_define(
   "DapLogPoint",
   {
      text = "",
      texthl = "DapLogPoint",
      linehl = "DapLogPoint",
      numhl = "DapLogPoint",
   }
)
vim.fn.sign_define(
   "DapStopped",
   { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
)

local DEBUGGER_PATH = vim.fn.stdpath("data")
   .. "/site/pack/packer/opt/vscode-js-debug"

require("dap-vscode-js").setup({
   node_path = "node",
   debugger_path = DEBUGGER_PATH,
   -- debugger_cmd = { "js-debug-adapter" },
   adapters = {
      "pwa-node",
      "pwa-chrome",
      "pwa-msedge",
      "node-terminal",
      "pwa-extensionHost",
   }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
   require("dap").configurations[language] = {
      {
         type = "pwa-node",
         request = "launch",
         name = "Launch file",
         program = "${file}",
         cwd = "${workspaceFolder}",
      },
      {
         type = "pwa-node",
         request = "attach",
         name = "Attach",
         processId = require("dap.utils").pick_process,
         cwd = "${workspaceFolder}",
      },
      {
         type = "pwa-node",
         request = "launch",
         name = "Debug Jest Tests",
         -- trace = true, -- include debugger info
         runtimeExecutable = "node",
         runtimeArgs = {
            "./node_modules/jest/bin/jest.js",
            "--runInBand",
         },
         rootPath = "${workspaceFolder}",
         cwd = "${workspaceFolder}",
         console = "integratedTerminal",
         internalConsoleOptions = "neverOpen",
      },
      {
         type = "pwa-chrome",
         name = "Attach - Remote Debugging",
         request = "attach",
         program = "${file}",
         cwd = vim.fn.getcwd(),
         sourceMaps = true,
         protocol = "inspector",
         port = 9222,
         webRoot = "${workspaceFolder}",
      },
      {
         type = "pwa-chrome",
         name = "Launch Chrome",
         request = "launch",
         url = "http://localhost:3000",
      },
   }
end
for _, language in ipairs({ "typescriptreact", "javascriptreact" }) do
   require("dap").configurations[language] = {
      {
         type = "pwa-chrome",
         name = "Attach - Remote Debugging",
         request = "attach",
         program = "${file}",
         cwd = vim.fn.getcwd(),
         sourceMaps = true,
         protocol = "inspector",
         port = 9222,
         webRoot = "${workspaceFolder}",
      },
      {
         type = "pwa-chrome",
         name = "Launch Chrome",
         request = "launch",
         url = "http://localhost:3000",
      },
   }
end
