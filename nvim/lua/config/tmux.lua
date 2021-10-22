-- init.lua or config/tmux.lua
local map = vim.api.nvim_set_keymap

map('n', '<m-h>', [[<cmd>lua require('tmux').move_left()<cr>]], { silent = true })
map('n', '<m-j>', [[<cmd>lua require('tmux').move_down()<cr>]], { silent = true })
map('n', '<m-k>', [[<cmd>lua require('tmux').move_up()<cr>]], { silent = true })
map('n', '<m-l>', [[<cmd>lua require('tmux').move_right()<cr>]], { silent = true })
map('i', '<m-h>', [[<cmd>lua require('tmux').move_left()<cr>]], { silent = true })
map('i', '<m-j>', [[<cmd>lua require('tmux').move_down()<cr>]], { silent = true })
map('i', '<m-k>', [[<cmd>lua require('tmux').move_up()<cr>]], { silent = true })
map('i', '<m-l>', [[<cmd>lua require('tmux').move_right()<cr>]], { silent = true })
