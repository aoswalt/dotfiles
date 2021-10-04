local M = {}

function M.prompt_vars(vars)
  local query_vars = {}

  for var, default in pairs(vars) do
    local value = M.prompt_var(var, default)
    query_vars[var] = value
  end

  return query_vars
end

function M.prompt_var(var, default)
  if default == vim.NIL or not default then
    default = ''
  end

  vim.fn.inputsave()
  local value = vim.fn.input(var .. ': ', default)
  vim.fn.inputrestore()

  if value == '' then
    error("PromptDB: No value given for '" .. var .. "'")
  end

  return value
end

return M
