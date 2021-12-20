local M = {}

M.on_attach = function(_client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local function buf_keymap(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end

  buf_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
  buf_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
  buf_keymap('n', '1gd', '<cmd>vsp | lua vim.lsp.buf.definition()<cr>')
  buf_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.declaration()<cr>')
  buf_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<cr>')
  buf_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
  buf_keymap('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
  buf_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
  buf_keymap('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
  buf_keymap('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>')
  buf_keymap('n', '<F10>', '<cmd>lua vim.diagnostic.open_float()<cr>')
  buf_keymap('n', 'gA', '<cmd>Telescope lsp_code_actions<CR>')
  buf_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({ wrap = true })<cr>')
  buf_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next({ wrap = true })<cr>')
  buf_keymap('n', '[w', '<cmd>lua vim.diagnostic.goto_prev({ wrap = true })<cr>')
  buf_keymap('n', ']W', '<cmd>lua vim.diagnostic.goto_next({ wrap = true })<cr>')

  buf_keymap('n', '<f4>', '<cmd>lua vim.lsp.buf.formatting()<cr>')
  buf_keymap('v', '<f4>', ':lua vim.lsp.buf.range_formatting()<cr>')

  buf_keymap('n', '<f3>', '<cmd>lua vim.lsp.buf.rename()<cr>')
end

return M
