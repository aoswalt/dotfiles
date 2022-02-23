local Job = require('plenary.job')

function elixir_test(type)
  args = { 'test' }

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
    vim.notify('Running all tests for file')
  else
    error('Unknown type for tests:', type)
  end

  Job:new({
      command = 'mix',
      args = args,
      cwd = vim.fn.getcwd(),
      on_exit = function(j, return_val)
        if return_val == 0 then
          vim.schedule(function()
            vim.notify('Tests run successfully')
          end)
        else
          result = table.concat(j:result(), '\n')
          vim.schedule(function()
            vim.notify(result, vim.diagnostic.severity.ERROR)
          end)
        end
      end,
    }):start()
end

vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>lua elixir_test("line")<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>tf', '<cmd>lua elixir_test("file")<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ta', '<cmd>lua elixir_test("all")<cr>', { noremap = true })
