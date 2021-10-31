local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local action_set = require('telescope.actions.set')
local finders = require('telescope.finders')
local make_entry = require('telescope.make_entry')
local pickers = require('telescope.pickers')
local previewers = require('telescope.previewers')
local utils = require('telescope.utils')
local conf = require('telescope.config').values
local log = require('telescope.log')

-- db = finders.new_oneshot_job(
--   vim.tbl_flatten{"ls"}, {}
-- )

-- db = finders.new_oneshot_job(
--   vim.fn["db#execute_command"]('', 0, 1, 0, [[select schemaname, tablename from pg_catalog.pg_tables]])
-- )

function mysplit(inputstr, sep)
  if sep == nil then
    sep = '%s'
  end

  local t = {}

  for str in string.gmatch(inputstr, '([^' .. sep .. ']+)') do
    table.insert(t, str)
  end

  return t
end

list_tables_cmd = function()
  return {
    'psql',
    '--no-psqlrc',
    '--expanded',
    '-c',
    [[copy (select schemaname || '.' || tablename from pg_catalog.pg_tables) to stdout]],
  }
end

list_columns_cmd = function(full_name)
  local results = mysplit(full_name, '.')
  local schema = results[1]
  local table = results[2]
  return {
    'psql',
    '--no-psqlrc',
    '--expanded',
    '-c',
    [[copy (select column_name, data_type from information_schema.columns where table_schema = ']]
      .. schema
      .. [[' and table_name = ']]
      .. table
      .. [[') to stdout]],
  }
end

table_previewer = previewers.new_buffer_previewer({
  define_preview = function(self, entry)
    cmd = list_columns_cmd(entry.value)
    require('telescope.previewers.utils').job_maker(cmd, self.state.bufnr)
  end,
})

field_picker = function(tbl)
  pickers.new(opts, {
    finder = finders.new_table({
      results = utils.get_os_command_output(list_columns_cmd(tbl)),
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        -- print("Selected: ", selection.display)
        vim.cmd('normal! a' .. selection[1])
        vim.cmd('stopinsert')
      end)

      return true
    end,
  }):find()
end

pickers.new(opts, {
  finder = finders.new_table({
    results = utils.get_os_command_output(list_tables_cmd()),
  }),
  previewer = table_previewer,
  sorter = conf.generic_sorter({}),
  attach_mappings = function(prompt_bufnr, map)
    actions.select_default:replace(function()
      local selection = action_state.get_selected_entry()
      actions.close(prompt_bufnr)

      -- print("Selected: ", selection.display)
      vim.cmd('normal! a' .. selection[1])
      vim.cmd('stopinsert')
    end)

    local fields = function()
      local current_picker = action_state.get_current_picker(prompt_bufnr)
      local full_name = action_state.get_selected_entry()[1]

      actions.close(prompt_bufnr, true)
      field_picker(full_name)
    end

    map('i', '<c-f>', fields)
    map('n', '<c-f>', fields)

    return true
  end,
}):find()
