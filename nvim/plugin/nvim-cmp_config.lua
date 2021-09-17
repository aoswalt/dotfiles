local cmp = require('cmp')

cmp.setup {
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },

  -- You must set mapping if you want.
  mapping = {
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-b>'] = cmp.mapping.scroll_docs(-4),
    ['<c-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<c-space>'] = cmp.mapping.complete(),
    ['<c-l>'] = cmp.mapping.complete(),
    ['<c-e>'] = cmp.mapping.close(),
    --TODO(adam): needed for lsp snippets but clunky for luasnip snippet triggering
    -- ['<c-j>'] = cmp.mapping.confirm({
    --   behavior = cmp.ConfirmBehavior.Insert,
    --   -- select = true,
    -- })
  },

  -- You should specify your *installed* sources.
  sources = {
    { name = 'buffer' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

vim.api.nvim_command[[
autocmd FileType lua lua require'cmp'.setup.buffer {
    sources = {
      { name = 'buffer' },
      { name = 'path' },
      { name = 'calc' },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'nvim_lua' },
    },
  }
]]
