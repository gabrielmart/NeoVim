require("lspsaga").setup({
   ui = {
      code_action = "",
   },
   scroll_preview = {
      scroll_down = "<C-j>",
      scroll_up = "<C-k>",
   },

   code_action = {
      keys = {
         quit = "<Esc>",
      },
   },

   rename = {
      quit = "<Esc>",
   },
})
