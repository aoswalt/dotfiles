return {
  -- {
  --   'vhyrro/luarocks.nvim',
  --   priority = 1000,
  --   config = true,
  --   opts = {
  --     -- jsregexp is for luasnip. a separate option is provided there if the
  --     -- only needed option for luarocks later
  --     rocks = { 'lua-curl', 'nvim-nio', 'mimetypes', 'xml2lua', 'jsregexp' },
  --   },
  -- },
  -- {
  --   'rest-nvim/rest.nvim',
  --   ft = 'http',
  --   dependencies = { 'luarocks.nvim' },
  --   main = 'rest-nvim',
  --   config = function()
  --     require('rest-nvim').setup({
  --       keybinds = {
  --         {
  --           '<leader>rr',
  --           '<cmd>Rest run<cr>',
  --           'Run request under the cursor',
  --         },
  --         {
  --           '<leader>rl',
  --           '<cmd>Rest run last<cr>',
  --           'Re-run latest request',
  --         },
  --       },
  --     })
  --   end,
  -- },
}
