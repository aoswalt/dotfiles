local output_bufnr = 12

local result = {
  module = '',
  file = '',
  test = '',
  time = nil,
  line = -1,
  success = true,
  output = {},
}

local function parse_line(line)

  local module_name, file = string.match(line, '^(%S+) %[([^]]+)%]$')

  local test_name, timing, line_nr = (
    string.match(line, '  %* test ([^(]+) %[L#(%d+)%]')
    or string.match(line, '  %* test ([^(]+) %((.+)%) %[L#(%d+)%]')
  )

    local test_name, timing =
      string.match(line, '  %d+%) test ([^(]+) %((.+)%)')
end

ns = vim.api.nvim_create_namespace('my test')
local function run_tests()
  local bufnr = vim.api.nvim_get_current_buf()
  local test_file = '/Users/adam/dev/golgi/test/md_web/controllers/facility_controller_test.exs'
  -- vim.fn.expand('%')
  local cmd = { 'mix', 'test', '--trace', test_file }

  local output = {}

  -- vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

  buffer_clear()

  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if not data then
        return
      end

      for _, line in ipairs(data) do
        table.insert(output, line)
      end

      -- vim.api.nvim_buf_set_extmark(bufnr, ns, 1, 0, {
      --   virt_text = { { 'did the thing' } },
      -- })

      buffer_print('output', output)
    end,

    on_stderr = function(_, data) buffer_print('error', data) end,

    on_exit = function(_, data) buffer_print('exit', data) end,
  })
end

local function buffer_print(label, data)
  vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, { '-- ' .. label })

  if type(data) == 'table' then
    vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, data)
  else
    for line in data:gmatch('[^\n]+') do
      vim.api.nvim_buf_set_lines(output_bufnr, -1, -1, false, { line })
    end
  end
end

local function buffer_clear() vim.api.nvim_buf_set_lines(output_bufnr, 0, -1, false, {}) end

local M = {}

local function parse_line(line, context)
  local module_name, file = string.match(line, '^(%S+) %[([^]]+)%]$')

  local module = nil

  if module_name then
    module = { module = module_name, file = file }
  end

  local test_name, timing, line_nr = (
    string.match(line, '  %* test ([^(]+) %[L#(%d+)%]')
    or string.match(line, '  %* test ([^(]+) %((.+)%) %[L#(%d+)%]')
  )
  if test_name then
    success = true
  end

  if not test_name then
    local test_name, timing =
      string.match(line, '  %d+%) test ([^(]+) %((.+)%)')
    if test_name then
      success = false
    end
  end

  local test = nil

  if test_name then
    test = {
      module = context.module,
      file = context.file,
      test = test_name,
      timing = timing,
      line = line_nr,
      success = success,
      output = {},
    }
  end

  if module or test then
    line = nil
  end

  return module, test, line
end

function M.parse_tests(data)
  local before_tests = true
  local current_test_file = nil
  local after_tests = false

  local current_module_context = nil
  local current_test = nil

  local preamble = {}
  local tests = {}
  local summary = {}

  for _, line in ipairs(data) do
    local module, test, line = parse_line(line, current_module_context)

    print(vim.inspect({ module = module, test = test, line = line }))

    if module and current_test then
      table.insert(tests, current_test)
    end

    if module then
      current_module_context = module
      before_tests = false
    end

    if test and current_test then
      table.insert(tests, current_test)
    end

    if line and current_test then
      if string.match(line, '^%S') then
        after_tests = true
      else
        table.insert(current_test.output, line)
        line = nil
      end
    end

    current_test = test

    if line and before_tests then
      table.insert(preamble, line)
      line = nil
    end

    if line and after_tests then
      table.insert(summary, line)
      line = nil
    end

    if line and string.match(line, '^%s+$') then
      line = nil
    end

    assert(not line, 'unprocessed line: ' .. vim.inspect(line))
  end

  return {
    preamble = preamble,
    tests = tests,
    summary = summary,
  }
end

return M

-- vim.api.nvim_create_user_command('RunTests', parse_tests, { desc = 'run elixir tests' })
