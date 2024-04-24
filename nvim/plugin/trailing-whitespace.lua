vim.fn.matchadd('Error', [[\s\+$]])

local function strip_whitespace()
  local save = vim.fn.winsaveview()
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.fn.winrestview(save)
end

vim.api.nvim_create_user_command(
  'StripWhitespace',
  strip_whitespace,
  { desc = 'Strip trailing whitespace' }
)

vim.api.nvim_create_autocmd(
  { 'BufWritePre' },
  { callback = strip_whitespace, desc = 'Strip trailing whitespace on save' }
)
