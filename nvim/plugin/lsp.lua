local lspconfig = require('lspconfig')
local my_lsp = require('my.lsp')

-- server capabilities in spec
-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities

local servers = { 'eslint', 'tsserver', 'rust_analyzer', 'dockerls', 'bashls', 'gdscript' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = my_lsp.on_attach,
    capabilities = my_lsp.capabilities,
  })
end

lspconfig.vimls.setup({
  -- don't want to override built-in keybinds for vim
  capabilities = capabilities,
})

require('zk').setup({
  picker = 'telescope',
  lsp = { config = { on_attach = on_attach } },
})
