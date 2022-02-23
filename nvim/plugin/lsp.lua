local lspconfig = require('lspconfig')

local function on_attach(client, bufnr)
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
  buf_keymap('n', 'gA', '<cmd>Telescope lsp_code_actions<CR>')

  if client.resolved_capabilities.document_formatting then
    buf_keymap('n', '<f4>', '<cmd>lua vim.lsp.buf.formatting()<cr>')
  end

  if client.resolved_capabilities.document_range_formatting then
    buf_keymap('v', '<f4>', ':lua vim.lsp.buf.range_formatting()<cr>')
  end

  buf_keymap('n', '<f3>', '<cmd>lua vim.lsp.buf.rename()<cr>')
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
