local Job = require('plenary.job')
local ui = require('my.ui')

vim.bo.makeprg = 'mix'

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

  Job:new({
    command = 'mix',
    args = args,
    cwd = vim.fn.getcwd(),
    on_exit = function(j, return_val)
      if return_val == 0 then
        vim.schedule(function() vim.notify('Tests run successfully') end)
      else
        vim.schedule(function()
          float = ui.make_output_window({ filetype = 'ElixirTests' })
          for _, line in ipairs(j:result()) do
            vim.api.nvim_chan_send(float.job_id, line .. '\r\n')
          end
        end)
      end
    end,
  }):start()
end

vim.keymap.set('n', '<leader>tt', '<cmd>lua elixir_test("line")<cr>')
vim.keymap.set('n', '<leader>tf', '<cmd>lua elixir_test("file")<cr>')
vim.keymap.set('n', '<leader>ta', '<cmd>lua elixir_test("all")<cr>')
