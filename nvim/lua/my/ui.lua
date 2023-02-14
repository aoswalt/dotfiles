local M = {}

local win_float = require('plenary.window.float')

local default_win_options = {
  winhl = 'Normal:Normal',
  conceallevel = 3,
  concealcursor = 'n',
}

-- stolen from plenary's test_harness
M.make_output_window = function(win_options_arg)
  win_options = vim.tbl_extend('keep', win_options_arg or {}, default_win_options)

  res = win_float.percentage_range_window(0.95, 0.70, { winblend = 3 })

  res.job_id = vim.api.nvim_open_term(res.bufnr, {})
  vim.api.nvim_buf_set_keymap(res.bufnr, 'n', 'q', ':q<cr>', { noremap = true })

  vim.api.nvim_win_set_option(res.win_id, 'winhl', win_options.winhl)
  vim.api.nvim_win_set_option(res.win_id, 'conceallevel', win_options.conceallevel)
  vim.api.nvim_win_set_option(res.win_id, 'concealcursor', win_options.concealcursor)

  if res.border_win_id then
    vim.api.nvim_win_set_option(res.border_win_id, 'winhl', win_options.winhl)
  end

  if res.bufnr and win_options.filetype then
    vim.api.nvim_buf_set_option(res.bufnr, 'filetype', win_options.filetype)
  end

  if res.bufnr and win_options.syntax then
    vim.api.nvim_buf_set_option(res.bufnr, 'syntax', win_options.syntax)
  end

  vim.cmd('mode')

  return res
end

return M
