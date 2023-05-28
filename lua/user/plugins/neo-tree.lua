local M = {}
-- vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
-- test
vim.g.neo_tree_remove_legacy_commands = 1

require("neo-tree").setup({
   source_selector = {
      winbar = true,
      content_layout = "center",
   },
   filesystem = {
      filtered_items = {
         hide_dotfiles = false,
         hide_gitignored = false,
         hide_by_name = {
            ".git",
         },
      },
   },
   use_libuv_file_watcher = true,
})

return M
