local lspconfig = require('lspconfig')
local lsp = require('lsp')

U.keymap('n', '<f4>', '<cmd>echoerr "No lsp for formatting set"<cr>')
U.keymap('v', '<f4>', '<cmd>echoerr "No lsp for formatting set"<cr>')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- set default for all servers
lspconfig.util.default_config = vim.tbl_extend('force', lspconfig.util.default_config, { capabilities = capabilities })

local servers = { 'eslint', 'rls', 'dockerls', 'bashls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({ on_attach = lsp.on_attach })
end

lspconfig.vimls.setup({})

lspconfig.elixirls.setup({
  cmd = { (vim.env.ELIXIR_LS_EXECUTABLE or (vim.loop.os_homedir() .. '/.tools/elixir-ls/language_server.sh')) },
  on_attach = lsp.on_attach,
  capabilities = capabilities,
})

lspconfig.tsserver.setup({
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false

    local ts_utils = require('nvim-lsp-ts-utils')

    ts_utils.setup({ enable_formatting = true })
    ts_utils.setup_client(client)

    lsp.on_attach(client, bufnr)
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

    lsp.on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  },
})
