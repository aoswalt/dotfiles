return { -- Collection of various small independent plugins/moules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    -- local gen_ai_spec = require('mini.extra').gen_ai_spec
    -- require('mini.ai').setup({
    --   n_lines = 500,
    --   search_method = 'cover',
    --   custom_textobjects = {
    --     b = require('mini.ai').gen_spec.pair('(', ')', { type = 'balanced'}),
    --     B = require('mini.ai').gen_spec.pair('{', '}', { type = 'balanced'}),
    --     [','] = require('mini.ai').gen_spec.argument(),
    --
    --     e = gen_ai_spec.buffer(),
    --     D = gen_ai_spec.diagnostic(),
    --     I = gen_ai_spec.indent(),
    --     l = gen_ai_spec.line(),
    --     L = gen_ai_spec.line(),
    --     N = gen_ai_spec.number(),
    --
    --     -- https://github.com/echasnovski/mini.nvim/issues/151
    --     -- camelCase
    --     V = {
    --       {
    --         '%u[%l%d]+%f[^%l%d]',
    --         '%f[%S][%l%d]+%f[^%l%d]',
    --         '%f[%P][%l%d]+%f[^%l%d]',
    --         '^[%l%d]+%f[^%l%d]',
    --       },
    --       '^().*()$',
    --     },
    --
    --     -- camel_case
    --     v = {
    --       {
    --         -- a*aa_bbb
    --         { '[^%w]()()[%w]+()_()' },
    --         -- a*aa_bb
    --         { '^()()[%w]+()_()' },
    --         -- aaa_bbb*_ccc
    --         { '_()()[%w]+()_()' },
    --         -- bbb_cc*cc
    --         { '()_()[%w]+()()%f[%W]' },
    --         -- bbb_cc*c at the end of the line
    --         { '()_()[%w]+()()$' },
    --       },
    --     },
    --   },
    -- })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    -- require('mini.surround').setup()
    require('mini.pairs').setup()
  end,
}
