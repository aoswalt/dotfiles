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
}
