return {
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup({
        pairs = {
          ['-'] = { '<%', '%>' },
          ['='] = { '<%=', '%>' },
        },
        highlight = { -- Highlight before inserting/changing surrounds
          duration = 100, -- millisections
        },
      })
    end,
  },
  {
    'windwp/nvim-autopairs',
    config = true,
  },
  {
    'windwp/nvim-ts-autotag',
    config = function()
      -- require'nvim-treesitter.configs'.setup {
      --   autotag = {
      --     enable = true,
      --   }
      -- }

      require('nvim-ts-autotag').setup({
        enable_rename = false,
        close_on_slash = false,
      })
    end,
  },
}
