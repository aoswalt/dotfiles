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

return U
