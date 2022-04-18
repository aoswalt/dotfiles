local function open_gh()
  local word = vim.fn.expand('<cWORD>')
  local repo = string.match(word, '[%w%.%-]+/[%w%.%-]+')

  if repo then
    local url = 'https://github.com/' .. repo
    vim.cmd("!open '" .. url .. "'")
  else
    vim.notify('No match of current word for "user/repo"', vim.log.levels.ERROR)
  end
end

vim.api.nvim_create_user_command(
  'OpenGithub',
  open_gh,
  { desc = 'Open a Github page when on a string like "user/repo"' }
)
