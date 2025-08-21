local M = {}

function M.on_attach(client, bufnr)
  vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local function map(keys, func, desc, mode)
    vim.keymap.set(mode or 'n', keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc, silent = true })
  end

  map('K', vim.lsp.buf.hover, 'Hover')
  map('<c-k>', vim.lsp.buf.signature_help, 'Signature Help')

  map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
  map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  map('1grd', function()
    vim.cmd('vsplit')
    vim.lsp.buf.definition()
  end, '[G]oto [D]efinition in Vertical Split')

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

  map('<f4>', vim.lsp.buf.format, 'lsp format with ' .. client.name)
  map('<f4>', vim.lsp.buf.format, 'lsp range format with ' .. client.name, 'x')
end

-- M.capabilities = require('cmp_nvim_lsp').default_capabilities()
M.capabilities = require('blink.cmp').get_lsp_capabilities()

return M
