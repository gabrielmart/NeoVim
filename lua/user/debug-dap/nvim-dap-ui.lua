require("dapui").setup({
  sidebar = {
      -- You can change the order of elements in the sidebar
      elements = {
        -- Provide as ID strings or tables with "id" and "size" keys
        { id = "scopes", size = 0.25 }, -- Can be float or integer > 1
        { id = "stacks", size = 0.25 },
        { id = "breakpoints", size = 0.25 },
        { id = "watches", size = 00.25 },
      },
      size = 50,
      position = "right", -- Can be "left", "right", "top", "bottom"
  },
})
