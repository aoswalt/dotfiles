local lspconfig = require('lspconfig')

U.keymap('n', '<f4>', '<cmd>echoerr "No lsp for formatting set"<cr>')
U.keymap('v', '<f4>', '<cmd>echoerr "No lsp for formatting set"<cr>')

local on_attach = function(client, bufnr)
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
  buf_keymap('n', '<F10>', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>')
  buf_keymap('n', 'gA', '<cmd>Telescope lsp_code_actions<CR>')
  buf_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({ wrap = true })<cr>')
  buf_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({ wrap = true })<cr>')
  buf_keymap('n', '[w', '<cmd>lua vim.lsp.diagnostic.goto_prev({ wrap = true })<cr>')
  buf_keymap('n', ']W', '<cmd>lua vim.lsp.diagnostic.goto_next({ wrap = true })<cr>')

  buf_keymap('n', '<f4>', '<cmd>lua vim.lsp.buf.formatting()<cr>')
  buf_keymap('v', '<f4>', ':lua vim.lsp.buf.range_formatting()<cr>')

  buf_keymap('n', '<f3>', '<cmd>lua vim.lsp.buf.rename()<cr>')
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- set default for all servers
lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, { capabilities = capabilities })

local servers = { 'eslint', 'rls', 'dockerls', 'null-ls', 'bashls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({ on_attach = on_attach })
end

lspconfig.vimls.setup({})

lspconfig.elixirls.setup({
  cmd = { (vim.env.ELIXIR_LS_EXECUTABLE or (vim.loop.os_homedir() .. '/.tools/elixir-ls/language_server.sh')) },
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false

    local ts_utils = require('nvim-lsp-ts-utils')

    ts_utils.setup({ enable_formatting = true })
    ts_utils.setup_client(client)

    on_attach(client, bufnr)
  end,
})

lspconfig.gdscript.setup({
  on_attach = function(client, bufnr)
    local _notify = client.notify

    client.notify = function(method, params)
      if method == 'textDocument/didClose' then
        -- Godot doesn't implement didClose yet
        return
      end
      _notify(method, params)
    end

    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  },
})
