local my_lsp = require('my.lsp')

-- server capabilities in spec
-- https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#serverCapabilities

local servers = { 'rust_analyzer', 'dockerls', 'bashls', 'gdscript', 'postgres_lsp' }

for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = my_lsp.on_attach,
    capabilities = my_lsp.capabilities,
  })
end

vim.lsp.config('lua_ls', {
  on_attach = my_lsp.on_attach,
  capabilities = my_lsp.capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT"
      },
      workspace = {
        userThirdParty = { "~/.tools/lls-addons" },
        library = { "~/.tools/lls-addons/love2d" },
      },
      diagnostics = {
        workspaceDelay = 2000,
      },
      hint = {
        enable = true,
      },
      format = {
        defaultConfig = {
          indent_style = "space",
          indent_width = 2,
          quote_style = "single",
          trailing_table_separator = "smart"
        }
      }
    }
  }
})

for _, lsp in ipairs({ 'eslint', 'ts_ls' }) do
  vim.lsp.config(lsp, {
    on_attach = function(client, bufnr)
      my_lsp.on_attach(client, bufnr)
      if vim.fn.exists(':EslintFixAll') then
        vim.keymap.set('n', '<f4>', '<cmd>EslintFixAll<cr>', { buffer = true, silent = true })
      end
    end,
    capabilities = my_lsp.capabilities,
  })
end

vim.lsp.config('tailwindcss', {
  -- filetypes = {
  --   -- html
  --   'eelixir',
  --   'elixir',
  --   'html',
  --   'heex',
  --   -- css
  --   'css',
  --   -- js
  --   'javascript',
  --   'javascriptreact',
  --   'typescript',
  --   'typescriptreact',
  --   -- mixed
  --   'vue',
  --   'svelte',
  -- },
  on_attach = function(client, bufnr)
    my_lsp.on_attach(client, bufnr)
    require('telescope').load_extension('tailiscope')
    vim.keymap.set('n', '<leader>sT', '<cmd>Telescope tailiscope<cr>')
  end,
  capabilities = my_lsp.capabilities,
  init_options = {
    userLanguages = {
      heex = 'phoenix-heex',
    },
  },
})

vim.lsp.config('vimls', {
  -- don't want to override built-in keybinds for vim
  capabilities = my_lsp.capabilities,
})

-- require('zk').setup({
--   picker = 'telescope',
--   lsp = { config = { on_attach = my_lsp.on_attach } },
-- })

vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
