vim.opt_local.commentstring = '// %s'

vim.api.nvim_buf_create_user_command(
  0,
  'GlslViewer',
  function() require('glsl').start_viewer() end,
  { desc = 'Start glslViewer for current file' }
)

vim.keymap.set(
  'n',
  '<space>d',
  function() require('glsl').start_viewer() end,
  { buffer = 0, desc = 'Start glslViewer for current file' }
)

vim.keymap.set(
  'n',
  '<space>D',
  '<cmd>below terminal glslViewer %<cr>',
  { buffer = 0, desc = 'Start glslViewer in terminal for current file' }
)
