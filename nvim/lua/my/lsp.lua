local M = {}

local function has_attached_server(server_name)
  for _, server in ipairs(vim.lsp.buf_get_clients()) do
    if server.name == server_name then
      return true
    end
  end

  return false
end

function M.on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local function buf_keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = true, silent = true })
  end

  buf_keymap('n', 'K', function() vim.lsp.buf.hover() end)
  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  buf_keymap('n', 'gd', function() vim.lsp.buf.definition() end)
  buf_keymap('n', '1gd', function()
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
  end)
  buf_keymap('n', '<c-]>', function() vim.lsp.buf.declaration() end)
  buf_keymap('n', 'gD', function() vim.lsp.buf.implementation() end)
  buf_keymap('n', '<c-k>', function() vim.lsp.buf.signature_help() end)
  buf_keymap('n', '1gD', function() vim.lsp.buf.type_definition() end)
  buf_keymap('n', 'gr', function() vim.lsp.buf.references() end)
  buf_keymap('n', 'g0', function() vim.lsp.buf.document_symbol() end)
  buf_keymap('n', 'gW', function() vim.lsp.buf.workspace_symbol() end)
  buf_keymap('n', '<f10>', function() vim.diagnostic.open_float() end) -- default is <c-w>d
  buf_keymap('n', 'gA', function() vim.lsp.buf.code_action() end)
  buf_keymap('v', 'gA', function() vim.lsp.buf.range_code_action() end)
  buf_keymap(
    'n',
    '<f4>',
    function() vim.lsp.buf.format() end,
    { desc = 'lsp format with ' .. client.name }
  )
  buf_keymap(
    'v',
    '<f4>',
    function() vim.lsp.buf.format() end,
    { desc = 'lsp range format with ' .. client.name }
  )

  buf_keymap('n', '<f3>', function() vim.lsp.buf.rename() end)
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities()

return M
