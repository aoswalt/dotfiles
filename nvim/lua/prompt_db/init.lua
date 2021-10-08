local M = {}

M.db_vars = M.db_vars or {}

--TODO(adam): use `\set` and var quoting instead?
-- let l:query = substitute(l:query, "\\v[^:]:'?(\\w+)'?", {matches -> printf(":'%s'", add(l:vars, matches[1])[-1])}, 'g')
-- call map(l:vars, {i, p -> printf('\set %s %s\;', p[0], p[1])})
-- exec printf('DB %s %s', join(l:vars, ' '), l:query)

--NOTE(adam): would rather not have 2 patterns but can't figure out how to make
--replacement work with 1 capture but not nested substitutution
local var_find_pattern = "[^%w:]:(%w+)"
local var_replace_pattern = "([^%w:]):(%w+)"

function M.prompt_db(query)
  query = vim.fn.substitute(query, "\n$", '', 'g')

  local vars = M.get_vars(query)

  local vars_with_defaults = {}
  for _, var in ipairs(vars) do
    vars_with_defaults[var] = M.db_vars[var] or vim.NIL
  end

  function on_submit(query_vars)
    local replaced_query = string.gsub(query, var_replace_pattern, function(leading, var)
      return leading .. query_vars[var]
    end)

    M.db_vars = vim.tbl_extend('force', M.db_vars, query_vars)

    --TODO(adam): pass in other DB options like bang and db
    vim.cmd('DB ' .. replaced_query)
  end

  require('prompt_db.prompt_buffer').prompt_vars(vars_with_defaults, on_submit)
end

function M.get_vars(query)
  local vars = {}

  for var in string.gmatch(query, var_find_pattern) do
    vars[var] = true
  end

  return vim.tbl_keys(vars)
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
