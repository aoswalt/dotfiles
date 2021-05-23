inspect = function(...)
  print(vim.inspect(...))
end

reload = function(module)
  require'plenary'.reload.reload_module(module)
  return require(module)
end
