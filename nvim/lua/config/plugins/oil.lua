return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup({
        view_options = {
          show_hidden = true,
        },
      })

      vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })

      vim.keymap.set('n', '<leader>-', '<cmd>vsp | Oil %:p:h | wincmd =<cr>', { silent = true })
      vim.keymap.set('n', '<leader>_', '<cmd>sp | Oil %:p:h | wincmd =<cr>', { silent = true })
    end,
  },
}
