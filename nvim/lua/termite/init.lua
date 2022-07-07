local termite = {}

termite.repl_var = 'termite_repl_job_id'

-- " cwd/% + path
termite.repl_base_config = {
  path = '.',
  cmd = '$SHELL',
  mapper = function(arg) return arg end,
}

termite.cmd_to_config = function(cmd)
  local conf = vim.deepcopy(config)
  conf.cmd = cmd
  return conf
end

local repls = {
  _default = '$SHELL',
  elixir = 'iex',
}

termite.get_terminal_job_id = function()
  local var = vim.b[termite.repl_var]

  if not var then
    error('termite: No terminal job id found in buffer')
  end

  return var
end

termite.yank_job_id = function(register)
  register = register or vim.v.register
  local term_job_id = termite.get_terminal_job_id()
  vim.fn.setreg(register, term_job_id)
end

function termite.put_job_id(register)
  register = register or vim.v.register

  local maybe_id = getreg(register)

  if not string.match(maybe_id, '%d+') then
    error(
      string.format(
        'termite: Given value of `%s` in register `%s` is not a valid job id',
        maybe_id,
        register
      )
    )
  end

  local job_id = vim.fn.str2nr(maybe_id)

  termite.set_job_id(job_id)
end

function termite.set_job_id()
  local job_id = termite.get_terminal_job_id()
  set_job_id(job_id)
end

local function set_job_id(job_id)
  if type(job_id) ~= 'number' then
    error(string.format('termite: set_job_id was not called with a number. got: `%s`', job_id))
  end

  vim.t[termite.repl_var] = job_id

  print('Set job id for current tab')
end

local function get_most_local(var_name, default)
  for _, scope in ipairs({ vim.b, vim.w, vim.t, vim.g }) do
    local value = scope[var_name]

    if value then
      return value
    end
  end

  return default
end

function termite.repl_send()
  local job_id = get_most_local(termite.repl_var)

  if not job_id then
    error('termite: No terminal job id found')
  end

  print(job_id)
end

return termite
