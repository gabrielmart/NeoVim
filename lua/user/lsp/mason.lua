local lspconfig = require("lspconfig")
require("mason").setup()
require("mason-lspconfig").setup()
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
require("mason-lspconfig").setup_handlers(handlers)

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "󰠠" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end
