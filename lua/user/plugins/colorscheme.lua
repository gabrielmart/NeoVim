local M = {}

require("catppuccin").setup({
   highlight_overrides = {
      mocha = function(C)
         return {
            TabLineSel = { bg = C.pink },
            CmpBorder = { fg = C.surface2 },
            Pmenu = { bg = C.none },
            TelescopeBorder = { link = "FloatBorder" },
         }
      end,
   },
})

vim.cmd.colorscheme("catppuccin")

return M
