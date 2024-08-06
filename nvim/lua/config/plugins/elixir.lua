return {
  'elixir-tools/elixir-tools.nvim',
  version = '*',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local elixir = require('elixir')
    local elixirls = require('elixir.elixirls')
    local my_lsp = require('my.lsp')

    elixir.setup({
      -- failing about dependencies as of 10/9
      nextls = {
        enable = false,
        -- port = 9000,
        experimental = {
          completions = {
            enable = true,
          },
        },
        on_attach = my_lsp.on_attach,
      },
      credo = { enable = true },
      elixirls = {
        enable = true,
        settings = elixirls.settings({
          dialyzerEnabled = true,
          fetchDeps = false,
          enableTestLenses = true,
          suggestSpecs = false,
        }),
        on_attach = my_lsp.on_attach,
      },
    })
  end,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
}
