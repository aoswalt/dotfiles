local lspconfig = require'lspconfig'

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local function buf_keymap(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end

  buf_keymap('n', 'K',      '<cmd>lua vim.lsp.buf.hover()<cr>')
  buf_keymap('n', 'gd',     '<cmd>lua vim.lsp.buf.definition()<cr>')
  buf_keymap('n', '1gd',    '<cmd>vsp | lua vim.lsp.buf.definition()<cr>')
  buf_keymap('n', '<c-]>',  '<cmd>lua vim.lsp.buf.declaration()<cr>')
  buf_keymap('n', 'gD',     '<cmd>lua vim.lsp.buf.implementation()<cr>')
  buf_keymap('n', '<c-k>',  '<cmd>lua vim.lsp.buf.signature_help()<cr>')
  buf_keymap('n', '1gD',    '<cmd>lua vim.lsp.buf.type_definition()<cr>')
  buf_keymap('n', 'gr',     '<cmd>lua vim.lsp.buf.references()<cr>')
  buf_keymap('n', 'g0',     '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
  buf_keymap('n', 'gW',     '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>')
  buf_keymap('n', '<F10>',  '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
  buf_keymap('n', 'gA',     '<cmd>lua vim.lsp.buf.code_action()<CR>')
  buf_keymap('n', '[d',     '<cmd>lua vim.lsp.diagnostic.goto_prev({ wrap = true })<cr>')
  buf_keymap('n', ']d',     '<cmd>lua vim.lsp.diagnostic.goto_next({ wrap = true })<cr>')

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_keymap('n', '<s-f4>', '<cmd>lua vim.lsp.buf.formatting()<cr>')
  elseif client.resolved_capabilities.document_range_formatting then
    buf_keymap('n', '<s-f4>', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
  else
    buf_keymap('n', '<s-f4>', '<cmd>echoerr "formatting not supported by any active client"<cr>')
  end

  if client.resolved_capabilities.rename then
    buf_keymap('n', '<f3>',   '<cmd>lua vim.lsp.buf.rename()<cr>')
  else
    buf_keymap('n', '<f3>',   '<cmd>echoerr "rename not supported by any active client"<cr>')
  end
end

-- seems to partly work but doesn't expand tabs into space
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true;

-- -- set default for all servers
-- lspconfig.util.default_config = vim.tbl_extend(
--   'force',
--   lspconfig.util.default_config,
--   { on_attach = on_attach }
-- )

-- turn off virtual text? not sure what the idea was
-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     underline = false,
--     virtual_text = false,
--     signs = true,
--     update_in_insert = false,
--   }
-- )

lspconfig.elixirls.setup{
  cmd = { (vim.env.ELIXIR_LS_EXECUTABLE or (vim.loop.os_homedir() .. '/.tools/elixir-ls/language_server.sh')) };
  on_attach = on_attach;
  -- capabilities = capabilities;
}

lspconfig.vimls.setup{}

local servers = { 'tsserver', 'rls', 'dockerls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup { on_attach = on_attach }
end
