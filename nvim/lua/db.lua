local M = {}

local Job = require('plenary.job')

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
      (all_fields) @star))
  (from
    (relation
      (table_reference
        schema: (identifier)? @schema
        name: (identifier) @table
      ) @table_reference
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
  if vim.treesitter.get_node_at_cursor() ~= 'all_fields' then
    error('Not on a *')
    return
  end

  local query = vim.treesitter.parse_query('sql', query_string)

  local parser = vim.treesitter.get_parser(0, 'sql')
  local tree = unpack(parser:parse())

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local cur_node = vim.treesitter.get_node_at_pos(0, row - 1, col, {})
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

return M
