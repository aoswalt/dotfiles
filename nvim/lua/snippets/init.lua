local ls = require('luasnip')

ls.config.setup({
  update_events = 'TextChanged,TextChangedI',
})

vim.keymap.set(
  { 'i', 's' },
  '<c-.>',
  function() return require('luasnip').choice_active() and require('luasnip').change_choice(1) end,
  { desc = 'Luasnip - Iterate over active choices', }
)

vim.keymap.set(
  { 'i', 's' },
  '<c-,>',
  function() return require('luasnip').choice_active() and require('luasnip').change_choice(-1) end,
  { desc = 'Luasnip - Iterate over active choices backward', }
)

require('luasnip.loaders.from_lua').load({
  paths = vim.api.nvim_get_runtime_file('lua/snippets/ft', false)[1],
})

ls.filetype_extend('javascriptreact', { 'javascript' })
ls.filetype_extend('typescriptreact', { 'typescript' })
