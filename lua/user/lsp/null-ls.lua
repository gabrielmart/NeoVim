local null_ls = require("null-ls")

require("mason-null-ls").setup({
   ensure_installed = { "luacheck", "stylua" },
   automatic_setup = true,
   handlers = {},
})

null_ls.setup({
   sources = {
      null_ls.builtins.code_actions.eslint,
      null_ls.builtins.diagnostics.eslint,
   },
})