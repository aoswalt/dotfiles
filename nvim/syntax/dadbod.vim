if exists("b:current_syntax")
  finish
endif

syn match dadbod_null '<null>'
syn match dadbod_number '\<\zs-\?\d\+\(\.\d\+\)\?\ze\>'
syn match dadbod_date '\d\{2,4\}-\d\{1,2\}-\d\{1,2\}'
syn match dadbod_time '\d\{1,2\}:\d\{1,2\}\(:\d\{1,2\}\)\?'
syn keyword dadbod_boolean true false t f
syn match dadbod_tableFieldSeparator ' \zs|\ze '
syn match dadbod_tableSeparatorLine '\(-\{-\}+-\+\)\+'

let b:current_syntax = "dadbod"

hi! link dadbod_null PreProc
hi! link dadbod_number Number
hi! link dadbod_date Number
hi! link dadbod_time Number
hi! link dadbod_boolean Constant
hi! link dadbod_tableFieldSeparator Delimiter
hi! link dadbod_tableSeparatorLine PreProc
" hi! def dadbod_tableSeparatorLine guifg=#667207
