-- blacklist for line length markers
-- vim.wo.colorcolumn = ""
--
-- vim.wo.foldenable = false
-- vim.wo.spell = true
-- vim.wo.wrap = true
-- vim.wo.linebreak = true

-- the lua versions seem to persist across windows?
vim.cmd([[
  let &colorcolumn=""

  setlocal nofoldenable | setlocal spell | setlocal wrap | setlocal linebreak
]])

vim.keymap.set('n', '<leader>md', '<Plug>MarkdownPreview')
vim.keymap.set('n', '<leader>mD', '<Plug>MarkdownPreviewStop')

local toggle_checkbox = function()
  local toggles = {
    ['[ ]'] = '[x]',
    ['[x]'] = '[ ]',
  }

  local line = vim.fn.getline('.')

  if string.match(line, '%[.%]') then
    local updated_line = string.gsub(line, '%[.%]', toggles, 1)
    vim.fn.setline('.', updated_line)
  end
end

vim.keymap.set('n', '<leader>t', toggle_checkbox, { desc = 'toggle checkbox' })
