local ls = require('luasnip')

ls.config.set_config({
  updateevents = 'TextChanged,TextChangedI',
})

-- vim.api.nvim_set_keymap('i', '<c-j>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'", { expr = true, noremap = false, silent = true })
vim.api.nvim_set_keymap(
  'i',
  '<c-j>',
  "luasnip#expand_or_locally_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'",
  { expr = true, noremap = false, silent = true }
)
vim.api.nvim_set_keymap('s', '<c-j>', "<cmd>lua require'luasnip'.jump(1)<cr>", { silent = true, noremap = true })

vim.api.nvim_set_keymap('i', '<c-k>', "<cmd>lua require'luasnip'.jump(-1)<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap('s', '<c-k>', "<cmd>lua require'luasnip'.jump(-1)<cr>", { silent = true, noremap = true })

vim.api.nvim_set_keymap(
  'i',
  '<c-e>',
  "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-e>'",
  { expr = true, noremap = false, silent = true }
)
vim.api.nvim_set_keymap(
  's',
  '<c-e>',
  "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-e>'",
  { expr = true, noremap = false, silent = true }
)

require('luasnip.loaders.from_lua').load({ paths = vim.api.nvim_get_runtime_file('lua/snippets/ft', false)[1] })
