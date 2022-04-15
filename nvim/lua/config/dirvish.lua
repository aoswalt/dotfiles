vim.g.dirvish_mode = ':sort'

vim.keymap.set('n', '<leader>x', '<cmd>vsp | Dirvish % | wincmd =<cr>', { silent = true })
vim.keymap.set('n', '<leader>X', '<cmd>sp | Dirvish % | wincmd =<cr>', { silent = true })
