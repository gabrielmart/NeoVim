local null_ls = require("null-ls")

null_ls.setup()

require("mason-null-ls").setup({
	ensure_installed = { "eslint_d", "luacheck", "stylua" },
	automatic_setup = true,
	handlers = {},
})
