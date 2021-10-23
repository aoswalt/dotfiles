local null_ls = require('null-ls')
local h = require('null-ls.helpers')

return h.make_builtin({
  method = null_ls.methods.FORMATTING,
  filetypes = { 'sql' },
  generator_opts = {
    command = 'pg_format',
    args = {
      '--comma-start',
      '--comma-break',
      '--spaces',
      '2',
      '--keyword-case',
      '1',
      '--wrap-after',
      '1',
      '--placeholder',
      '":: "',
    },
    to_stdin = true,
  },
  factory = h.formatter_factory,
})
