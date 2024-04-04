local function run_sh(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, true)

  vim.cmd({ cmd = 'terminal', args = lines })
end

-- nvim_buf_get_text

-- - In Visual mode  you can use `line('v')` and `col('v')` to get one end of the
--   Visual area, the cursor is at the other end.

vim.api.nvim_create_user_command('Sh', run_sh, { range = true, desc = 'run shell script in term window' })
