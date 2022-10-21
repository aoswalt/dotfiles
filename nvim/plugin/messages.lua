local function buffer_messages()
  local foo = vim.api.nvim_exec('messages', true)

  vim.cmd('new')
  vim.api.nvim_paste(foo, true, -1)

  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.modified = false
  vim.bo.modifiable = false
  vim.bo.buflisted = false
end

vim.api.nvim_create_user_command(
  'Messages',
  buffer_messages,
  { desc = 'Put :messages ouput into a new buffer' }
)
