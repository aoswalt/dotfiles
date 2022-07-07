local M = {}

local Job = require('plenary.job')

M.get_table_columns = function(table_schema_or_name, table_name, db_url)
  --TODO(adam): split if given like 'schema.table'
  if table_name then
    table_schema = table_schema_or_name
  else
    table_schema = 'public'
    table_name = table_schema_or_name
  end

  db_url = db_url or vim.b.db or vim.g.db

  local args = {
    db_url,
    '--no-psqlrc',
    '--tuples-only',
    '--pset=format=unaligned',
    '-c',
    [[select column_name from information_schema.columns where table_schema = ']]
      .. table_schema
      .. [['and table_name = ']]
      .. table_name
      .. [[']],
  }

  Job:new({
    command = 'psql',
    args = args,
    cwd = vim.fn.getcwd(),
    on_exit = function(j, return_val)
      if return_val == 1 then
        error(vim.inspect(j:result()))
      end

      local columns = table.concat(j:result(), ', ')
      vim.schedule(function() vim.paste({ columns }, -1) end)
    end,
  }):start()
end

return M
