local M = {}

M.db_vars = M.db_vars or {}

--TODO(adam): use `\set` and var quoting instead?
-- let l:query = substitute(l:query, "\\v[^:]:'?(\\w+)'?", {matches -> printf(":'%s'", add(l:vars, matches[1])[-1])}, 'g')
-- call map(l:vars, {i, p -> printf('\set %s %s\;', p[0], p[1])})
-- exec printf('DB %s %s', join(l:vars, ' '), l:query)

local var_pattern = "[^%w:]:(%w+)"

function M.prompt_db(query)
  query = vim.fn.substitute(query, "\n$", '', 'g')

  local query_vars = {}
  for var in pairs(M.get_vars(query)) do
    local value = M.prompt_var(var)
    query_vars[var] = value
  end

  local replaced_query = string.gsub(query, '(' .. var_pattern .. ')', function(full, var)
    return string.gsub(full, ':' .. var, M.db_vars[var])
  end)

  --TODO(adam): pass in other DB options like bang and db
  vim.cmd('DB ' .. replaced_query)
end

function M.get_vars(query)
  local vars = {}
  for var in string.gmatch(query, var_pattern) do
    vars[var] = true
  end
  return vars
end

--TODO(adam): consider a prompt buffer for better ux
function M.prompt_var(var)
  local default = M.db_vars[var] or ''

  vim.fn.inputsave()
  local value = vim.fn.input(var .. ': ', default)
  vim.fn.inputrestore()

  if value == '' then
    error("PromptDB: No value given for '" .. var .. "'")
  end

  M.db_vars[var] = value

  return value
end

function M.prompt_db_op(type)
  selection = U.get_visual_selection(type)

  M.prompt_db(selection)
end

function M.prompt_db_range(line1, line2)
  lines = vim.fn.getline(line1, line2)
  --NOTE(adam): traling shouldn't matter but makes results match
  text = table.concat(lines, "\n") .. "\n"

  M.prompt_db(text)
end

return M
