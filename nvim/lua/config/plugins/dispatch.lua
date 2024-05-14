return {
  'tpope/vim-dispatch',
  config = function()
    vim.g.dispatch_no_tmux_make = 1
    vim.g.dispatch_no_tmux_start = 1
    vim.g.dispatch_no_screen_make = 1
    vim.g.dispatch_no_screen_start = 1

    vim.keymap.set('n', '<leader>d', '<cmd>Dispatch<cr>')
  end,
}
