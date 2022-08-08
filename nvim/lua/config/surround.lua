require('nvim-surround').setup({
  pairs = {
    ['-'] = { '<%', '%>' },
    ['='] = { '<%=', '%>' },
  },
  highlight = { -- Highlight before inserting/changing surrounds
    duration = 100, -- millisections
  },
})
