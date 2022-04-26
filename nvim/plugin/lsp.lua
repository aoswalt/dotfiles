local lspconfig = require('lspconfig')

-- server capabilities in spec
-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local function buf_keymap(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = true, silent = true })
  end

  buf_keymap('n', 'K', function() vim.lsp.buf.hover() end)
  buf_keymap('n', 'gd', function() vim.lsp.buf.definition() end)
  buf_keymap('n', '1gd', function() vim.cmd('vsplit'); vim.lsp.buf.definition() end)
  buf_keymap('n', '<c-]>', function() vim.lsp.buf.declaration() end)
  buf_keymap('n', 'gD', function() vim.lsp.buf.implementation() end)
  buf_keymap('n', '<c-k>', function() vim.lsp.buf.signature_help() end)
  buf_keymap('n', '1gD', function() vim.lsp.buf.type_definition() end)
  buf_keymap('n', 'gr', function() vim.lsp.buf.references() end)
  buf_keymap('n', 'g0', function() vim.lsp.buf.document_symbol() end)
  buf_keymap('n', 'gW', function() vim.lsp.buf.workspace_symbol() end)
  buf_keymap('n', 'gA', function() vim.lsp.buf.code_action() end)
  buf_keymap('v', 'gA', function() vim.lsp.buf.range_code_action() end)

  if client.server_capabilities.documentFormattingProvider then
    buf_keymap('n', '<f4>', function() vim.lsp.buf.formatting() end)
  end

  if client.server_capabilities.documentRangeFormattingProvider then
    buf_keymap('v', '<f4>', function() vim.lsp.buf.range_formatting() end)
  end

  buf_keymap('n', '<f3>', function() vim.lsp.buf.rename() end)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local servers = { 'elixirls', 'eslint', 'tsserver', 'rls', 'dockerls', 'bashls', 'gdscript' }

local configs = {
  elixirls = {
    cmd = { (vim.env.ELIXIR_LS_EXECUTABLE or (vim.loop.os_homedir() .. '/.tools/elixir-ls/language_server.sh')) },
  },
}

for _, lsp in ipairs(servers) do
  local config = configs[lsp] or {}
  config.on_attach = on_attach
  config.capabilities = capabilities

  lspconfig[lsp].setup(config)
end

lspconfig.vimls.setup({
  -- don't want to override built-in keybinds for vim
  capabilities = capabilities,
})

require('zk').setup({
  picker = 'telescope',
  lsp = { config = { on_attach = on_attach } },
})
