return {
  'junegunn/limelight.vim',
  config = function()
    vim.g.limelight_conceal_ctermfg = 236
    vim.g.limelight_conceal_guifg = '#444444'

    vim.keymap.set('n', '<leader>l', '<cmd>Limelight<cr>')
    vim.keymap.set('n', '<leader>L', '<cmd>Limelight!<cr>')
    vim.keymap.set('x', '<leader>l', '<Plug>(Limelight)', { remap = true })
  end,
}
