local elixir = require('elixir')
local elixirls = require('elixir.elixirls')
local my_lsp = require('my.lsp')

elixir.setup({
  -- failing about dependencies as of 10/9
  nextls = {
    enable = true,
    -- port = 9000,
    experimental = {
      completions = {
        enable = true,
      },
    },
    on_attach = my_lsp.on_attach,
  },
  credo = { enable = false },
  elixirls = { enable = false },
})
