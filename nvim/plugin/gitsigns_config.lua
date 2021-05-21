require'gitsigns'.setup{
  --numhl = true,
  signs = {
    delete = {
      show_count = true,
    },
    topdelete = {
      show_count = true,
    },
  },
  count_chars = {
    [1]   = '₁',
    [2]   = '₂',
    [3]   = '₃',
    [4]   = '₄',
    [5]   = '₅',
    [6]   = '₆',
    [7]   = '₇',
    [8]   = '₈',
    [9]   = '₉',
    ['+'] = '₊',
  },
  keymaps = {
    noremap = true,
    buffer = true,

    ['n ]c'] = { expr = true, [[&diff ? ']c' : '<cmd>lua require"gitsigns".next_hunk()<CR>']] },
    ['n [c'] = { expr = true, [[&diff ? '[c' : '<cmd>lua require"gitsigns".prev_hunk()<CR>']] },
    ['n ]h'] = { '<cmd>lua require\"gitsigns\".next_hunk()<CR>' },
    ['n [h'] = { '<cmd>lua require\"gitsigns\".prev_hunk()<CR>' },

    ['n ghs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n ghu'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n ghU'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n ghr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n ghR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
    ['n ghp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
    ['n ghb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',

    -- Text objects
    ['o ic'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['x ic'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['o ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".select_hunk()<CR>'
  },
}

vim.api.nvim_set_keymap('n', '[oghs', "<cmd>lua require'gitsigns'.toggle_signs()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', ']oghs', "<cmd>lua require'gitsigns'.toggle_signs()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '[oghn', "<cmd>lua require'gitsigns'.toggle_numhl()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', ']oghn', "<cmd>lua require'gitsigns'.toggle_numhl()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '[oghl', "<cmd>lua require'gitsigns'.toggle_linehl()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', ']oghl', "<cmd>lua require'gitsigns'.toggle_linehl()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', '[oghb', "<cmd>lua require'gitsigns'.toggle_current_line_blame()<CR>", { silent = true })
vim.api.nvim_set_keymap('n', ']oghb', "<cmd>lua require'gitsigns'.toggle_current_line_blame()<CR>", { silent = true })
