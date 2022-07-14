require('nvim-surround').setup({
  pairs = {
    ['-'] = { '<%', '%>' },
    ['='] = { '<%=', '%>' },
  },
  highlight_motion = { -- Highlight before inserting/changing surrounds
    duration = 100, -- millisections
  },
})
