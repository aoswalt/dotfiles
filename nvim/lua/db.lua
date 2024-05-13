local M = {}

local Job = require('plenary.job')
local ui = require('my.ui')

local run_get_table_columns = function(schema_name, table_name, db_url, callback)
  table_schema = schema_name or 'public'

  db_url = db_url or vim.b.db or vim.g.db

  if not callback then
    error('No callback function given')
  end

  local args = {
    db_url,
    '--no-password',
    '--no-psqlrc',
    '--tuples-only',
    '--pset=format=unaligned',
    '-c',
    string.format(
      [[select column_name from information_schema.columns where table_schema = '%s'and table_name = '%s']],
      table_schema,
      table_name
    ),
  }

  Job:new({
    command = 'psql',
    args = args,
    cwd = vim.fn.getcwd(),
    -- env = { ['a'] = 'b' },
    on_exit = function(j, return_val)
      if return_val == 1 then
        error(vim.inspect(j:result()))
      end

      vim.schedule(function() callback(j:result()) end)
    end,
  }):start()
end

local query_string = [[
(statement (
  (select
    (select_expression
      (term
        value: (all_fields) @star)))
  (from
    (relation
      (object_reference
        schema: (identifier)? @schema
        name: (identifier) @table
      ) @object_reference
    )
  )
))
]]

local replace_node_text = function(node, new_text)
  local row1, col1 = node:start()
  local row2, col2 = node:end_()

  vim.api.nvim_buf_set_text(0, row1, col1, row2, col2, { new_text })
end

M.get_table_columns = function(db_url)
  if vim.treesitter.get_node():type() ~= 'all_fields' then
    error('Not on a *')
    return
  end

  local query = vim.treesitter.query.parse('sql', query_string)

  local parser = vim.treesitter.get_parser(0, 'sql')
  local tree = unpack(parser:parse())

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local cur_node = vim.treesitter.get_node()
  local statement_node = cur_node

  while cur_node:type() ~= 'statement' and cur_node:parent() ~= nil do
    cur_node = cur_node:parent()
  end

  local star_node
  local schema_name
  local table_name

  for id, node, metadata in query:iter_captures(cur_node, 0) do
    local name = query.captures[id] -- name of the capture in the query
    -- typically useful info about the node:
    local type = node:type() -- type of the captured node
    local row1, col1, row2, col2 = node:range() -- range of the capture

    if name == 'star' then
      star_node = node
    elseif name == 'table' then
      table_name = vim.treesitter.get_node_text(node, 0)
    elseif name == 'schema' then
      schema_name = vim.treesitter.get_node_text(node, 0)
    end
  end

  expanded_db_url = vim.fn.expand(db_url)
  if expanded_db_url == 'v:null' then
    expanded_db_url = nil
  end

  run_get_table_columns(schema_name, table_name, expanded_db_url, function(columns)
    if #columns == 0 then
      error(
        string.format(
          'No columns found for %s.%s using %s',
          schema_name or 'public',
          table_name,
          db_url
        )
      )
    end

    local columns = table.concat(columns, ', ')

    replace_node_text(star_node, columns)
  end)
end

local run_get_ddl = function(schema_name, table_name, db_url, callback)
  table_schema = schema_name or 'public'

  db_url = db_url or vim.b.db or vim.g.db

  if not callback then
    error('No callback function given')
  end

  table_pattern = string.format('%s.%s', schema_name or 'public', table_name)

  local args = {
    '--schema-only',
    '--table=' .. table_pattern,
  }

  if db_url then
    table.insert(args, '--dbname=' .. db_url)
  end

  Job:new({
    command = 'pg_dump',
    args = args,
    cwd = vim.fn.getcwd(),
    on_exit = function(j, return_val)
      if return_val == 1 then
        error(vim.inspect(j:result()))
      end

      vim.schedule(function() callback(j:result()) end)
    end,
  }):start()
end

M.get_ddl = function(args)
  db_url = nil
  schema_name = nil
  table_name = nil

  if #args == 3 then
    db_url = args[1]
    schema_name = args[2]
    table_name = args[3]
  elseif #args == 2 then
    db_url = args[1]
    table_name = args[2]
  elseif #args == 1 then
    table_name = args[1]
  end

  expanded_db_url = vim.fn.expand(db_url)
  if expanded_db_url == 'v:null' then
    expanded_db_url = nil
  end

  run_get_ddl(schema_name, table_name, expanded_db_url, function(output)
    float = ui.make_output_window({ filetype = 'sql', syntax = 'sql' })
    for _, line in ipairs(output) do
      vim.api.nvim_chan_send(float.job_id, line .. '\r\n')
    end
  end)
end

return M
