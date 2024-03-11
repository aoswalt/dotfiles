local cmp = require('cmp')
local ls = require('luasnip')
local lspkind = require('lspkind')

cmp.setup({
  mapping = {
    ['<c-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<c-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<c-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 's' }),
    ['<c-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 's' }),
    ['<c-space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<c-,>'] = cmp.mapping(function() ls.change_choice(-1) end, { 'i', 's' }),
    ['<c-.>'] = cmp.mapping(function() ls.change_choice(1) end, { 'i', 's' }),
    ['<c-l>'] = cmp.mapping(function()
      if ls.locally_jumpable(1) then
        ls.jump(1)
      end
    end, { 'i', 's' }),
    ['<c-h>'] = cmp.mapping(function()
      if ls.locally_jumpable(-1) then
        ls.jump(-1)
      end
    end, { 'i', 's' }),
    ['<c-e>'] = cmp.mapping(cmp.mapping.abort(), { 'i', 'c' }),
    -- ['<c-k>'] = cmp.mapping(function() ls.jump(-1) end, { 'i', 's' }),
    ['<c-y>'] = cmp.mapping(cmp.mapping.confirm({ select = false }), { 'i', 'c' }),
    ['<cr>'] = cmp.mapping.confirm({ select = false }),
    -- ['<c-cr>'] = cmp.mapping.confirm({ select = true }),
    ['<c-cr>'] = cmp.mapping(function(fallback)
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
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
    expand = function(args) require('luasnip').lsp_expand(args.body) end,
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
    { name = 'git' },
  }, {
    { name = 'buffer', keyword_length = 3 },
  }),
})

-- -- causing weird slowness with dadbod
-- require('cmp').setup.cmdline(':', {
--   sources = {
--     { name = 'cmdline', keyword_length = 3 },
--     { name = 'path', keyword_length = 2 },
--     { name = 'buffer', keyword_length = 3 },
--   },
-- })

require('cmp').setup.cmdline('/', {
  sources = {
    { name = 'buffer', keyword_length = 3 },
  },
})

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
