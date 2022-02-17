vim.g.kitty_navigator_no_mappings = 1

local map = vim.api.nvim_set_keymap

map('n', '<m-h>', [[<cmd>KittyNavigateLeft<cr>]], { silent = true })
map('n', '<m-j>', [[<cmd>KittyNavigateDown<cr>]], { silent = true })
map('n', '<m-k>', [[<cmd>KittyNavigateUp<cr>]], { silent = true })
map('n', '<m-l>', [[<cmd>KittyNavigateRight<cr>]], { silent = true })
map('i', '<m-h>', [[<cmd>KittyNavigateLeft<cr>]], { silent = true })
map('i', '<m-j>', [[<cmd>KittyNavigateDown<cr>]], { silent = true })
map('i', '<m-k>', [[<cmd>KittyNavigateUp<cr>]], { silent = true })
map('i', '<m-l>', [[<cmd>KittyNavigateRight<cr>]], { silent = true })
