local lspconfig = require("lspconfig")
local typescript_ok, typescript = pcall(require, "typescript")
require("mason").setup()
local mason_lsp_ok, mason_lsp = pcall(require, "mason-lspconfig")
require("neodev").setup()

local handlers = {
   -- The first entry (without a key) will be the default handler
   -- and will be called for each installed server that doesn't have
   -- a dedicated handler.
   function(server_name) -- default handler (optional)
      lspconfig[server_name].setup({})
   end,
   -- Next, you can provide targeted overrides for specific servers.
   ["lua_ls"] = function()
      lspconfig.lua_ls.setup({
         cmd = { "lua-language-server" },
         settings = {
            Lua = {
               runtime = {
                  -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                  version = "LuaJIT",
               },
               diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { "vim" },
               },
               workspace = {
                  library = vim.tbl_extend(
                     "keep",
                     -- this will probably vary depending on setup, not sure if plugins like mason even install it.
                     { "/usr/lib/lua-language-server/meta/template" },
                     -- and runtime-directories.
                     vim.api.nvim_get_runtime_file("", true)
                  ),
               }, -- Do not send telemetry data containing a randomized but unique identifier
               telemetry = {
                  enable = false,
               },
            },
         },
      })
   end,
}

mason_lsp.setup({
   ensure_installed = {
      "cssls",
      "eslint",
      "html",
      "jsonls",
      "lua_ls",
      -- 'tsserver',
   },
   automatic_installation = true,

   handlers = handlers,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

if typescript_ok then
   typescript.setup({
      disable_commands = false, -- prevent the plugin from creating Vim commands
      debug = false, -- enable debug logging for commands
      -- LSP Config options
      server = {
         capabilities = require("user.lsp.servers.tsserver").capabilities,
         handlers = require("user.lsp.servers.tsserver").handlers,
         on_attach = require("user.lsp.servers.tsserver").on_attach,
         settings = require("user.lsp.servers.tsserver").settings,
      },
   })
end

-- lspconfig.eslint.setup({
--   capabilities = capabilities,
--   handlers = handlers,
--   on_attach = require("user.lsp.servers.eslint").on_attach,
--   settings = require("user.lsp.servers.eslint").settings,
-- })

local signs = {
   { name = "DiagnosticSignError", text = "" },
   { name = "DiagnosticSignWarn", text = "" },
   { name = "DiagnosticSignHint", text = "󰠠" },
   { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
   vim.fn.sign_define(
      sign.name,
      { texthl = sign.name, text = sign.text, numhl = "" }
   )
end

-- require('mason-lspconfig').setup_handlers(handlers)
