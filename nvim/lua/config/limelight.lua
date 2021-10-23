vim.g.limelight_conceal_ctermfg = 236
vim.g.limelight_conceal_guifg = '#444444'

U.keymap('n', '<leader>l', '<cmd>Limelight<cr>')
U.keymap('n', '<leader>L', '<cmd>Limelight!<cr>')
U.keymap('x', '<leader>l', '<Plug>(Limelight)', { noremap = false })
