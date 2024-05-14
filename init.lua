-- install lazy if not found
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

-- needed for initial non-plugin loading, other handling inside of lazy
vim.opt.runtimepath:append({ '$DOTFILES/nvim' })

U = require('util')

require('settings')

require('lazy').setup({ import = 'config/plugins' }, {
  performance = {
    rtp = {
      paths = { vim.fn.expand('$DOTFILES/nvim'), vim.fn.expand('$DOTFILES/nvim/after') },
      disabledPlugins = {
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'vimball',
        'vimballPlugin',
        '2html_plugin',
        'spellfile_plugin',
      },
    },
  },
  change_detection = {
    notify = false,
  },
})

--  \"au BufReadPost * if getline(1) =~ \"VAR\" | call SetVar() | endif
-- And define a function SetVar() that does something with the line containing
-- "VAR" to do for a custom type of vim settings line

-- allow loading of device specific configs
if vim.fn.filereadable(vim.fn.expand('$HOME/init.after.vim')) > 0 then
  vim.cmd('source $HOME/init.after.vim')
end

if vim.fn.filereadable(vim.fn.expand('$HOME/init.after.lua')) > 0 then
  vim.cmd('source $HOME/init.after.lua')
end
