--   'hrsh7th/cmp-calc',
--   'onsails/lspkind-nvim',
-- require('cmp_git').setup()
-- cmp.setup.filetype('gitcommit', {
--   sources = cmp.config.sources({
--     { name = 'git' },
--   }, {
--     { name = 'buffer', keyword_length = 3 },
--   }),
-- })

return {
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        config = function() require('snippets') end,
      },
    },
    opts = {
      -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
      -- 'super-tab' for mappings similar to vscode (tab to accept)
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- All presets have the following mappings:
      -- C-space: Open menu or open docs if already open
      -- C-n/C-p or Up/Down: Select next/previous item
      -- C-e: Hide menu
      -- C-k: Toggle signature help (if signature.enabled = true)
      --
      keymap = {
        preset = 'default',
        ['<c-l>'] = { 'snippet_forward' },
        ['<c-h>'] = { 'snippet_backward' },
        ['<c-cr'] = {
          function()
            if require('luasnip').expand_or_jumpable() then
              require('luasnip').expand_or_jump()
              return true
            end
          end,
          'select_and_accept',
        },
        -- ['<c-.>'] = {
        --   function() return require('luasnip').choice_active() and require('luasnip').change_choice(1) end,
        -- }
        -- ['<c-,>'] = {
        --   function() return require('luasnip').choice_active() and require('luasnip').change_choice(-1) end,
        -- }
        -- https://github.com/Saghen/blink.cmp/issues/1545#issuecomment-2764864241
        ['<Tab>'] = { 'fallback' },
        ['<S-Tab>'] = { 'fallback' },
      },

      completion = {
        ghost_text = {
          enabled = true,
        },
        menu = {
          auto_show = false,
        },
        documentation = {
          auto_show = false,
          auto_show_delay_ms = 500,
        },
      },

      sources = {
        default = { 'snippets', 'lsp', 'path', 'buffer' },
      },

      snippets = { preset = 'luasnip' },

      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },

      signature = { enabled = false },
    },
    opts_extend = { 'sources.default' },
  },
}
