local Job = require('plenary.job')
local win_float = require('plenary.window.float')

-- stolen from plenary's test_harness
local function make_output_window()
  res = win_float.percentage_range_window(0.95, 0.70, { winblend = 3 })

  res.job_id = vim.api.nvim_open_term(res.bufnr, {})
  vim.api.nvim_buf_set_keymap(res.bufnr, 'n', 'q', ':q<cr>', { noremap = true })

  vim.api.nvim_win_set_option(res.win_id, 'winhl', 'Normal:Normal')
  vim.api.nvim_win_set_option(res.win_id, "conceallevel", 3)
  vim.api.nvim_win_set_option(res.win_id, 'concealcursor', 'n')

  if res.border_win_id then
    vim.api.nvim_win_set_option(res.border_win_id, 'winhl', 'Normal:Normal')
  end

  if res.bufnr then
    vim.api.nvim_buf_set_option(res.bufnr, 'filetype', 'ElixirTests')
  end
  vim.cmd('mode')

  return res
end

function elixir_test(type)
  args = { 'test', '--color' }

  if type == 'line' then
    file = vim.fn.expand('%')
    line = vim.fn.getcurpos()[2]

    path = file .. ':' .. line

    table.insert(args, path)
    vim.notify('Running tests for line: ' .. path)
  elseif type == 'file' then
    file = vim.fn.expand('%')

    table.insert(args, file)
    vim.notify('Running tests for file: ' .. file)
  elseif type == 'all' then
    -- no changes for all
    vim.notify('Running all tests')
  else
    error('Unknown type for tests:', type)
  end

  Job
    :new({
      command = 'mix',
      args = args,
      cwd = vim.fn.getcwd(),
      on_exit = function(j, return_val)
        if return_val == 0 then
          vim.schedule(function()
            vim.notify('Tests run successfully')
          end)
        else
          vim.schedule(function()
            float = make_output_window()
            for _, line in ipairs(j:result()) do
              vim.api.nvim_chan_send(float.job_id, line .. '\r\n')
            end
          end)
        end
      end,
    })
    :start()
end

vim.keymap.set('n', '<leader>tt', '<cmd>lua elixir_test("line")<cr>')
vim.keymap.set('n', '<leader>tf', '<cmd>lua elixir_test("file")<cr>')
vim.keymap.set('n', '<leader>ta', '<cmd>lua elixir_test("all")<cr>')
