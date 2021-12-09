local M = {}

local current_vars
local on_submit

function M.prompt_vars(vars, on_submit_)
  --NOTE(adam): vim.deepcopy errors on vim.NIL
  current_vars = {}
  for k,v in pairs(vars) do
    current_vars[k] = v
  end

  on_submit = on_submit_

  vim.cmd('new')
  M.display_buf()
end

function M.complete()
  vim.cmd('bw')
  on_submit(current_vars)
end

local current_prompt_var

local function on_complete_prompt(text)
  current_vars[current_prompt_var] = text
  curent_prompt_var = nil

  M.display_buf()
end

function M.prompt_line()
  local line = vim.fn.getline('.')
  local var = M.var_from_line(line)
  current_prompt_var = var

  vim.opt.buftype = 'prompt'
  vim.opt.modifiable = true

  local bufnr = vim.fn.bufnr()
  vim.fn.prompt_setcallback(bufnr, on_complete_prompt)

  local line = vim.fn.line('$')
  vim.fn.append(line, '=====')

  local current_value = current_vars[var]
  if current_value == nil or current_value == vim.NIL then
    current_value = ''
  end

  vim.fn.prompt_setprompt(bufnr, var .. ': ')

  vim.cmd('nnoremap <buffer> <esc> <cmd>lua require("prompt_db.prompt_buffer").display_buf()<cr>')

  vim.cmd('startinsert!')
end

function M.display_buf()
  M.print_vars()

  vim.opt.buftype = 'nofile'
  vim.opt.modifiable = false

  vim.cmd('nnoremap <buffer> <esc> <cmd>bw<cr>')
  vim.cmd('nnoremap <buffer> <cr> <cmd>lua require("prompt_db.prompt_buffer").prompt_line()<cr>')
  vim.cmd('nnoremap <buffer> <m-cr> <cmd>lua require("prompt_db.prompt_buffer").complete()<cr>')
end

function M.print_vars()
  local rows = M.make_display(current_vars)

  vim.opt.modifiable = true
  vim.cmd('%d')
  vim.api.nvim_put(rows, 'l', false, true)
  vim.cmd('.d') --NOTE(adam): remove trailing empty line
end

function M.make_display(vars)
  local rows = {}
  for var, value in pairs(vars) do
    if value == vim.NIL then
      value = nil
    end

    local row = string.format('%s: %s', var, value)
    table.insert(rows, row)
  end
  table.sort(rows)
  return rows
end

function M.var_from_line(line)
  -- use prompt_getprompt?
  return string.match(line, '(%w+):')
end

return M
