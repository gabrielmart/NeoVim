local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("n", "<F2>", ":lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<F3>", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", opts)
keymap("n", "<F4>", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>", opts)
keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", opts)
keymap("n", "<F6>", ":lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F7>", ":lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F8>", ":lua require'dap'.step_out()<CR>", opts)
keymap("n", "<F9>", ":lua require'dap'.repl.toggle()<CR>", opts)
keymap("n", "<F10>", ":lua require'dap'.disconnect()<CR>", opts)
