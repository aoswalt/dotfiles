local ls = require('luasnip')

ls.config.set_config({
  updateevents = 'TextChanged,TextChangedI',
})

vim.keymap.set(
  { 'i', 's' },
  '<c-e>',
  "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-e>'",
  { expr = true, remap = true, silent = true }
)

require('luasnip.loaders.from_lua').load({
  paths = vim.api.nvim_get_runtime_file('lua/snippets/ft', false)[1],
})
