local elixir = require('elixir')
local elixirls = require('elixir.elixirls')
local my_lsp = require('my.lsp')

elixir.setup({
  -- failing about dependencies as of 10/9
  nextls = { enable = false },
  credo = {},
  elixirls = {
    enable = true,
    settings = elixirls.settings({
      -- dialyzerEnabled = false,
      enableTestLenses = true,
    }),
    on_attach = function(client, bufnr)
      my_lsp.on_attach(client, bufnr)

      vim.keymap.set(
        'n',
        '<space>Ett',
        ':lua vim.lsp.codelens.run()<cr>',
        { buffer = true, noremap = true }
      )
      vim.keymap.set('n', '<space>Efp', ':ElixirFromPipe<cr>', { buffer = true, noremap = true })
      vim.keymap.set('n', '<space>Etp', ':ElixirToPipe<cr>', { buffer = true, noremap = true })
      vim.keymap.set('v', '<space>Eem', ':ElixirExpandMacro<cr>', { buffer = true, noremap = true })
    end,
  },
})
