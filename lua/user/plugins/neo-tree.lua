vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
require("neo-tree").setup({
 source_selector = {
    winbar = true,
   content_layout = "center",
 },
})

