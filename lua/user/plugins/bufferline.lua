local M = {}

local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
   return
end

local mocha = require("catppuccin.palettes").get_palette("mocha")

bufferline.setup({
   -- highlights = require("catppuccin.groups.integrations.bufferline").get(),
   options = {
      mode = "buffers",
      numbers = "both", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
      -- NOTE: this plugin is designed with this icon in mind,
      -- and so changing this is NOT recommended, this is intended
      -- as an escape hatch for people who cannot bear it for whatever reason
      indicator = {
         icon = "▎", -- this should be omitted if indicator style is not 'icon'
         style = "icon",
      },
      modified_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 30,
      max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
      tab_size = 20,
      offsets = {
         {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            padding = 1,
         },
      },
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = true,
      persist_buffer_sort = true,
      separator_style = { "", "" },
      enforce_regular_tabs = true,
      always_show_bufferline = true,
   },
})

return M
