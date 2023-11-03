local lspconfig = require('lspconfig')
local my_lsp = require('my.lsp')

-- server capabilities in spec
-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities

local servers = { 'rust_analyzer', 'dockerls', 'bashls', 'gdscript' }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = my_lsp.on_attach,
    capabilities = my_lsp.capabilities,
  })
end

for _, lsp in ipairs({ 'eslint', 'tsserver' }) do
  lspconfig[lsp].setup({
    on_attach = function(client, bufnr)
      my_lsp.on_attach(client, bufnr)
      if vim.fn.exists(':EslintFixAll') then
        vim.keymap.set('n', '<f4>', '<cmd>EslintFixAll<cr>', { buffer = true, silent = true })
      end
    end,
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
