vim.g.kitty_navigator_no_mappings = 1

vim.keymap.set({ 'n', 'i' }, '<m-h>', [[<cmd>KittyNavigateLeft<cr>]], { silent = true })
vim.keymap.set({ 'n', 'i' }, '<m-j>', [[<cmd>KittyNavigateDown<cr>]], { silent = true })
vim.keymap.set({ 'n', 'i' }, '<m-k>', [[<cmd>KittyNavigateUp<cr>]], { silent = true })
vim.keymap.set({ 'n', 'i' }, '<m-l>', [[<cmd>KittyNavigateRight<cr>]], { silent = true })
