local M = {}

function M.prompt_vars(vars, on_submit)
  local query_vars = {}

  for var, default in pairs(vars) do
    local value = prompt_var(var, default)
    query_vars[var] = value
  end

  on_submit(query_vars)
end

local function prompt_var(var, default)
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
