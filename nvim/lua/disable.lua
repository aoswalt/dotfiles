local disabled_built_ins = {
  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',
  -- 'gzip',
  -- 'zip',
  -- 'zipPlugin',
  -- 'tar',
  -- 'tarPlugin',
  'vimball',
  'vimballPlugin',
  '2html_plugin',
  'spellfile_plugin',
  -- 'matchit',
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g['loaded_' .. plugin] = 1
end
