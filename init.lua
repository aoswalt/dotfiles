-- install packer if not found
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
end

vim.opt.runtimepath = vim.opt.runtimepath + { '$DOTFILES/nvim', '$DOTFILES/nvim/after' }
vim.opt.packpath = vim.opt.packpath + '$DOTFILES/nvim'

U = require('util')

require('disable')
require('plugins')

vim.cmd('source $DOTFILES/nvim/settings.vim')

--  \"au BufReadPost * if getline(1) =~ \"VAR\" | call SetVar() | endif
-- And define a function SetVar() that does something with the line containing
-- "VAR" to do for a custom type of vim settings line

-- allow loading of device specific configs
if vim.fn.filereadable(vim.fn.expand('$HOME/init.after.vim')) > 0 then
  vim.cmd('source $HOME/init.after.vim')
end
