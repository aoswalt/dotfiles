return {
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    event = 'vimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function() return vim.fn.executable('make') == 1 end,
      },
      'nvim-telescope/telescope-ui-select.nvim',
      'nvim-telescope/telescope-github.nvim',
      'rlch/github-notifications.nvim',
      'danielvolchek/tailiscope.nvim',
    },
    config = function()
      require('config.telescope')

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('ui-select')
      require('telescope').load_extension('gh')
      require('telescope').load_extension('ghn')
    end,
  },
}
