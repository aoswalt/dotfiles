vim.g.dirvish_mode = ':sort'

U.keymap('n', '<leader>x', '<cmd>vsp | Dirvish % | wincmd =<cr>', { silent = true })
U.keymap('n', '<leader>X', '<cmd>sp | Dirvish % | wincmd =<cr>', { silent = true })
