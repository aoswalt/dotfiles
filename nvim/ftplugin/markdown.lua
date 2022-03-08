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

vim.api.nvim_buf_set_keymap(0, 'n', '<leader>md', '<Plug>MarkdownPreview', { noremap = false })
vim.api.nvim_buf_set_keymap(0, 'n', '<leader>mD', '<Plug>MarkdownPreviewStop', { noremap = false })


if require("zk.util").notebook_root(vim.fn.expand('%:p')) ~= nil then
  vim.opt_local.conceallevel = 2
end
