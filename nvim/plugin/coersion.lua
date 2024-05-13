local function snakecase(word)
  local word = vim.fn.substitute(word, '::', '/', 'g')
  local word = vim.fn.substitute(word,'\\(\\u\\+\\)\\(\\u\\l\\)','\\1_\\2','g')
  local word = vim.fn.substitute(word,'\\(\\l\\|\\d\\)\\(\\u\\)','\\1_\\2','g')
  local word = vim.fn.substitute(word, '[.-]', '_', 'g')
  local word = vim.fn.tolower(word)
  return word
end

local function spacecase(word) return vim.fn.substitute(snakecase(word), '_', ' ', 'g') end

local function titlecase(word)
  return vim.fn.substitute(spacecase(word), '(<w)', '=toupper(submatch(1))', 'g')
end

-- local function coerce(type)
--   if type !~# '^\%(line\|char\|block\)'
--     local &opfunc = matchstr(expand('<sfile>'), '<SNR>\w*')
--     return 'g@'
--   end
-- end
--
-- function! s:coerce(type) abort
--   let selection = &selection
--   let clipboard = &clipboard
--
--   try
--     set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
--     let regbody = getreg('"')
--     let regtype = getregtype('"')
--     let c = v:count1
--     let begin = getcurpos()
--
--     while c > 0
--       let c -= 1
--
--       if a:type ==# 'line'
--         let move = "'[V']"
--       elseif a:type ==# 'block'
--         let move = "`[\<C-V>`]"
--       else
--         let move = "`[v`]"
--       endif
--
--       silent exe 'normal!' move.'y'
--
--       let word = @@
--       let @@ = s:send(g:Abolish.Coercions,type,word)
--
--       if word !=# @@
--         let changed = 1
--         exe 'normal!' move.'p'
--       endif
--     endwhile
--
--     call setreg('"',regbody,regtype)
--     call setpos("'[",begin)
--     call setpos(".",begin)
--   finally
--     let &selection = selection
--     let &clipboard = clipboard
--   endtry
-- endfunction

-- nnoremap <expr> <Plug>(abolish-coerce) <SID>coerce(nr2char(getchar()))
-- vnoremap <expr> <Plug>(abolish-coerce) <SID>coerce(nr2char(getchar()))
-- nnoremap <expr> <Plug>(abolish-coerce-word) <SID>coerce(nr2char(getchar())).'iw'

-- nmap cr  <Plug>(abolish-coerce-word)
