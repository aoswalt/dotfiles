--NOTE(adam): can't use lua function for opfunc as far as I can tell
vim.cmd([[
function! PromptDB_OP(type = '') abort
  if a:type == ''
    set opfunc=PromptDB_OP
    return 'g@'
  endif

  call v:lua.require('prompt_db').prompt_db_op(a:type)
endfunction

function! PromptDB() range
  call v:lua.require('prompt_db').prompt_db_range(a:firstline, a:lastline)
endfunction

command! -range PromptDB exec PromptDB(<line1>, <line2>)
]])

vim.keymap.set({ 'n', 'v' }, '<leader>v', 'PromptDB_OP()', { expr = true })
vim.keymap.set('n', '<leader>vv', 'PromptDB_OP() .. "_"', { expr = true })
