local lspconfig = require'lspconfig'

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'K',      '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  buf_set_keymap('n', 'gd',     '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  buf_set_keymap('n', '1gd',    '<cmd>vsp | lua vim.lsp.buf.definition()<cr>', opts)
  buf_set_keymap('n', '<c-]>',  '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  buf_set_keymap('n', 'gD',     '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  buf_set_keymap('n', '<c-k>',  '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  buf_set_keymap('n', '1gD',    '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  buf_set_keymap('n', 'gr',     '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  buf_set_keymap('n', 'g0',     '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
  buf_set_keymap('n', 'gW',     '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>', opts)
  buf_set_keymap('n', '<F10>',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)

  buf_set_keymap('n', '[d',     '<cmd>lua vim.lsp.diagnostic.goto_prev({ wrap = true })<cr>', opts)
  buf_set_keymap('n', ']d',     '<cmd>lua vim.lsp.diagnostic.goto_next({ wrap = true })<cr>', opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<s-f4>', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', '<s-f4>', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  else
    buf_set_keymap('n', '<s-f4>',   '<cmd>echoerr "formatting not supported by any active client"<cr>', opts)
  end

  if client.resolved_capabilities.rename then
    buf_set_keymap('n', '<f3>',   '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  else
    buf_set_keymap('n', '<f3>',   '<cmd>echoerr "rename not supported by any active client"<cr>', opts)
  end
end

-- doesn't seem 100% yet, at least for elixir with snippets.nvim, see nvim-lspconfig
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true;

-- -- set default for all servers
-- lspconfig.util.default_config = vim.tbl_extend(
--   'force',
--   lspconfig.util.default_config,
--   { on_attach = on_attach }
-- )

lspconfig.elixirls.setup{
  cmd = { (vim.env.ELIXIR_LS_EXECUTABLE or (vim.loop.os_homedir() .. '/.tools/elixir-ls/language_server.sh')) };
  on_attach = on_attach;
}

lspconfig.tsserver.setup{
  on_attach = on_attach;
}

lspconfig.vimls.setup{}

lspconfig.rls.setup{
  on_attach = on_attach;
}
lspconfig.dockerls.setup{
  on_attach = on_attach;
}
