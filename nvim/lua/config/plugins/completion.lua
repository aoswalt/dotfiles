return {
  {
    'hrsh7th/nvim-cmp',
    config = function() require('config.cmp') end,
  },
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-calc',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-cmdline',
  'onsails/lspkind-nvim',
  {
    'L3MON4D3/LuaSnip',
    config = function() require('snippets') end,
  },
  'saadparwaiz1/cmp_luasnip',
}
