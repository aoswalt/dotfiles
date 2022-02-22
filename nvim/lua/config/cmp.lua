local cmp = require('cmp')
local lspkind = require('lspkind')

cmp.setup({
  mapping = {
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<c-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<c-l>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<c-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<c-j>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  sources = {
    { name = 'luasnip' },
    { name = 'calc' },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    {
      name = 'buffer',
      options = {
        -- get completion from visible buffers
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
      keyword_length = 4,
    },
    { name = 'path' },
  },

  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },

  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = '[buf]',
        nvim_lsp = '[LSP]',
        nvim_lua = '[api]',
        path = '[path]',
        luasnip = '[snip]',
        ['vim-dadbod-completion'] = '[db]',
      },
    }),
  },
})

require('cmp_git').setup()

cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' },
  }, {
    { name = 'buffer', keyword_length = 3 },
  }),
})

require('cmp').setup.cmdline(':', {
  sources = {
    { name = 'cmdline', keyword_length = 3 },
    { name = 'path', keyword_length = 2 },
    { name = 'buffer', keyword_length = 3 },
  },
})

require('cmp').setup.cmdline('/', {
  sources = {
    { name = 'buffer', keyword_length = 3 },
  },
})
