return {
  'petertriho/cmp-git',
  'tpope/vim-fugitive',
  {
    'junegunn/gv.vim',
    config = function() vim.keymap.set('n', '<leader>gv', '<cmd>GV<cr>') end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function() require('config.gitsigns') end,
  },
}
