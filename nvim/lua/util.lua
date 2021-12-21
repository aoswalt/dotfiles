local U = {}

U.inspect = function(...)
  print(vim.inspect(...))
end

U.reload = function(module)
  require'plenary'.reload.reload_module(module)
  return require(module)
end

local default_keyamp_opts = { noremap = true }

U.keymap = function(mode, lhs, rhs, opts_arg)
  local opts = vim.deepcopy(default_keyamp_opts)
  for k,v in pairs(opts_arg or {}) do opts[k] = v end

  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

U.buf_keymap = function(bufnr, mode, lhs, rhs, opts_arg)
  local opts = vim.deepcopy(default_keyamp_opts)
  for k,v in pairs(opts_arg or {}) do opts[k] = v end

  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
end

--NOTE(adam): words from mapping type, literals from visualmode()
local regtype_to_prefix = {
  line = '`[V`]',
  char = '`[v`]',
  block = '`[\\<C-V>`]',
  V = '`[V`]',
  v = '`<v`>',
  [''] = '`<\\<C-V>`>',
}

--NOTE(adam): there is a PR that should replace the need for this
--half is from ':h :map-operator' and half is from dadbod
function U.get_visual_selection(type)
  type = type or vim.fn.visualmode()

  local orig_selection = vim.o.selection
  local orig_clipboard = vim.o.clipboard
  local orig_unnamed = vim.fn.getreg('"')
  local orig_visual_start = vim.fn.getpos("'<")
  local orig_visual_end = vim.fn.getpos("'>")

  local selection

  local is_success = xpcall(function()
    vim.o.clipboard = ''
    vim.o.selection = 'inclusive'

    assert(regtype_to_prefix[type], 'Unknown regtype: ' .. vim.inspect(type))
    vim.cmd('silent noautocmd keepjumps normal! ' .. regtype_to_prefix[type] .. 'y')
    selection = vim.fn.getreg('"')
  end, function(err) print("ERROR: ", err) end)

  vim.o.selection = orig_selection
  vim.o.clipboard = orig_clipboard
  vim.fn.setreg('"', orig_unnamed)
  vim.fn.setpos("'<", orig_visual_start)
  vim.fn.setpos("'>", orig_visual_end)

  if not is_success then
    error("Failed to get selection")
  else
    return selection
  end
end

return U
