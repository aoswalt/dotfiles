" Not all terminals support italics properly. If yours does, opt-in.
" let g:terminal_italics = 0

" if g:terminal_italics == 0
"   if has_key(a:style, "cterm") && a:style["cterm"] == "italic"
"     unlet a:style.cterm
"   endif
" endif


" https://stackoverflow.com/questions/53538592/in-vimrc-apply-certain-highlighting-rules-only-for-certain-filetype


" Setup {{{1

set background=dark

" reset all highlighting to the defaults
highlight clear

" reset default colors (does not reset syntax items)
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "unemphatic"

" Helper Functions {{{1

function! s:h(group, style)
  " link style if string given
  if type(a:style) == v:t_string
    execute "highlight! link " . a:group . " " . a:style
    return
  endif

  let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
  let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
  let l:cterm = (has_key(a:style, "style") ? a:style.style : "NONE")

  execute "highlight" a:group
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm=" . l:cterm
    \ "gui=NONE"
    \ "guifg=NONE"
    \ "guibg=NONE"
    \ "guisp=NONE"
endfunction

" Color Palette {{{1

" using maps for ability to add gui in future and account for termguicolors
" set termguicolors

let s:red = {
\ "_": { "cterm": "203" },
\ "light": { "cterm": "210" },
\ "dark": { "cterm": "196" },
\ "dim": { "cterm": "124" },
\ "dim_dark": { "cterm": "52" },
\}

let s:orange = {
\ "_": { "cterm": "215" },
\ "light": { "cterm": "223" },
\ "dark": { "cterm": "208" },
\ "dim": { "cterm": "130" },
\ "dim_dark": { "cterm": "94" },
\}

let s:green = {
\ "_": { "cterm": "120" },
\ "light": { "cterm": "157" },
\ "dark": { "cterm": "34" },
\ "dim": { "cterm": "70" },
\ "dim_dark": { "cterm": "22" },
\}

let s:yellow = {
\ "_": { "cterm": "228" },
\ "light": { "cterm": "229" },
\ "dark": { "cterm": "220" },
\ "dim": { "cterm": "142" },
\ "dim_dark": { "cterm": "100" },
\}

let s:blue = {
\ "_": { "cterm": "39" },
\ "light": { "cterm": "117" },
\ "dark": { "cterm": "27" },
\ "dim": { "cterm": "25" },
\ "dim_dark": { "cterm": "20" },
\}

let s:purple = {
\ "_": { "cterm": "170" },
\ "light": { "cterm": "219" },
\ "dark": { "cterm": "135" },
\ "dim": { "cterm": "90" },
\ "dim_dark": { "cterm": "55" },
\}

let s:cyan = {
\ "_": { "cterm": "44" },
\ "light": { "cterm": "159" },
\ "dark": { "cterm": "37" },
\ "dim": { "cterm": "30" },
\ "dim_dark": { "cterm": "23" },
\}

let s:white = { "cterm": "15" }
let s:black = { "cterm": "0" }

let s:none = { "cterm": "NONE" }

let s:bg = {
\ "_": { "cterm": "NONE" },
\ "offset": { "cterm": 232 },
\ "highlight": { "cterm": 235 },
\ "dark": { "cterm": 234 },
\ "minimum": { "cterm": 233 },
\}

let s:fg = {
\ "_": s:white,
\ "offset": { "cterm": 251 },
\ "lessened": { "cterm": 244 },
\ "dark": { "cterm": 239 },
\ "minimum": { "cterm": 238 },
\}

let s:error = s:red.dark
let s:warning = s:yellow.dark
let s:special_grey = s:fg.dark
let s:visual_grey = s:fg.minimum

let s:inactive_bg = s:bg.minimum

let s:gutter_fg_grey = s:fg.minimum
let s:active_grey =  { "cterm": 245 }
let s:inactive_grey =  { "cterm": 236 }
let s:menu_grey = s:bg.dark
let s:menu_selection = { "cterm": 25 }

let s:control_statement = { "fg": s:blue.dim }

" Syntax Groups (descriptions and ordering from `:h w18`) {{{1

call s:h("Comment", { "fg": s:fg.minimum, "style": "italic" }) " any comment
call s:h("Constant", { "fg": s:orange.light }) " any constant
call s:h("String", { "fg": s:yellow.light }) " a string constant: "this is a string"
" call s:h("Character", "Constant") " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:orange.dark }) " a number constant: 234, 0xff
call s:h("Boolean", "Number") " a boolean constant: TRUE, false
call s:h("Float", "Number") " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:cyan.light }) " any variable name
" call s:h("Function", "Identifier") " function name (also: methods for classes)
call s:h("Statement", { "fg": s:blue.light }) " any statement
call s:h("Conditional", s:control_statement) " if, then, else, endif, switch, etc.
call s:h("Repeat", s:control_statement) " for, do, while, etc.
call s:h("Label", s:control_statement) " case, default, etc.
call s:h("Operator", { "fg": s:blue.light }) " 'sizeof', '+', '*', etc.
" call s:h("Keyword", "Statement") " any other keyword
call s:h("Exception", { "fg": s:red.dim }) " try, catch, throw
call s:h("PreProc", { "fg": s:fg.minimum }) " generic Preprocessor
" call s:h("Include", "PreProc") " preprocessor #include
" call s:h("Define", "PreProc") " preprocessor #define
" call s:h("Macro", "Define") " same as Define
" call s:h("PreCondit", "PreProc") " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:red.light }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:fg.minimum }) " static, register, volatile, etc.
" call s:h("Structure", "Type") " struct, union, enum, etc.
" call s:h("Typedef", "Type") " A typedef
call s:h("Special", { "fg": s:fg.offset }) " any special symbol
" call s:h("SpecialChar", "Special") " special character in a constant
" call s:h("Tag", "Special") " you can use CTRL-] on this
call s:h("Delimiter", { "fg": s:fg.lessened }) " character that needs attention
" call s:h("SpecialComment", "Special") " special things inside a comment
call s:h("Debug", "Special") " debugging statements
call s:h("Underlined", { "style": "underline" }) " text that stands out, HTML links
" call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:error }) " any erroneous construct
call s:h("Todo", { "fg": s:purple._ }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

call s:h("TSNote", { "fg": s:purple.light })
call s:h("TSConstBuiltin", "Constant")
call s:h("TSParameter", "Variable")
call s:h("TSVariable", "Variable")
call s:h("TSKeyword", "Keyword")
call s:h("elixirTSKeyword", "PreProc")
call s:h("TSKeywordFunction", "PreProc")
call s:h("TSSymbol", "Constant")
" call s:h("elixirTSType", "Constant")
call s:h("TSField", s:none)
call s:h("bashTSParameter", "NONE")
call s:h("TSAttribute", { "fg": s:purple.dim })


" Highlighting Groups (descriptions and ordering from `:h hitest.vim`) {{{1

call s:h("ColorColumn", { "bg": s:bg.offset }) " used for the columns set with 'colorcolumn'
" call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:none, "bg": s:blue._ }) " the character under the cursor
" call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "bg": s:bg.highlight }) " the screen column that the cursor is in when 'cursorcolumn' is set
call s:h("CursorLine", "CursorColumn") " the screen line that the cursor is in when 'cursorline' is set
call s:h("Directory", { "fg": s:blue._ }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:bg.dark }) " diff mode: Added line
call s:h("DiffChange", { "bg": s:bg.dark }) " diff mode: Changed line
call s:h("DiffDelete", { "fg": s:red._ }) " diff mode: Deleted line
call s:h("DiffText", { "fg": s:yellow._, "bg": s:visual_grey }) " diff mode: Changed text within a changed line
" call s:h("EndOfBuffer", {}) " filler lines (~) after the end of the buffer
" call s:h("TermCursor", {}) " cursor in a focused terminal
" call s:h("TermCursorNC", {}) " cursor in an unfocused terminal
call s:h("ErrorMsg", { "fg": s:error }) " error messages on the command line
call s:h("VertSplit", { "fg": s:white }) " the column separating vertically split windows
call s:h("Folded", { "fg": s:fg.minimum }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "fg": s:black, "bg": s:yellow.dim }) " 'incsearch' highlighting; also used for the text replaced with ':s///c'
" call s:h("Substitute", {}) " :substitute replacement text highlighting
call s:h("LineNr", { "fg": s:gutter_fg_grey }) " Line number for ':number' and ':#' commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "fg": s:blue._ }) " The character under the cursor or just before it, if it is a paired._ bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., '-- INSERT --')
" call s:h("MsgArea", {}) " Area for messages and cmdline
" call s:h("MsgSeparator", {}) " Separator for scrolled messages, `msgsep` flag of 'display'
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:fg.minimum }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., '>' displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", {}) " normal text
" call s:h("NormalFloat", "Pmenu") " normal text in floating windows
call s:h("NormalNC", { "bg": s:inactive_bg }) " normal text in non-current windows
call s:h("Pmenu", { "bg": s:menu_grey }) " Popup menu: normal item.
call s:h("PmenuSel", { "bg": s:menu_selection }) " Popup menu: selected item.
call s:h("PmenuSbar", { "bg": s:special_grey }) " Popup menu: scrollbar.
call s:h("PmenuThumb", { "bg": s:white }) " Popup menu: Thumb of the scrollbar.
call s:h("Question", { "fg": s:purple._ }) " hit-enter prompt and yes/no questions
" call s:h("QuickFixLine", {}) " Current quickfix item in the quickfix window. Combined with hl-CursorLine when the cursor is there
call s:h("Search", { "fg": s:black, "bg": s:yellow.dim }) " Last search pattern highlighting (see 'hlsearch'). Also used for highlighting the current line in the quickfix window and similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:special_grey }) " Meta and special keys listed with ':map', also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:error, "style": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:warning }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:warning }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:warning }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:black, "bg": s:active_grey }) " status line of current window
call s:h("StatusLineNC", { "fg": s:white, "bg": s:inactive_grey  }) " status lines of not-current windows Note: if this is equal to 'StatusLine' Vim will use '^^^' in the status line of the current window.
call s:h("TabLine", { "fg": s:fg.minimum }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:white }) " tab pages line, active tab page label
call s:h("Title", { "fg": s:green.light }) " titles for output from ':set all', ':autocmd' etc.
call s:h("Visual", { "fg": s:none, "bg": s:bg.highlight }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:visual_grey }) " Visual mode selection when vim is 'Not Owning the Selection'. Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:warning }) " warning messages
" call s:h("Whitespace", {}) " 'nbsp', 'space', 'tab' and 'trail' in 'listchars'
call s:h("WildMenu", {}) " current match in 'wildmenu' completion

" Syntax highlighting groups {{{2

call s:h("RedrawDebugClear", { "fg": s:black, "bg": s:yellow.dark })
call s:h("RedrawDebugComposed", { "fg": s:black, "bg": s:green.dark })
call s:h("NvimInternalError", { "fg": s:white, "bg": s:red.dark })


" Language-Specific Highlighting {{{1

" CSS {{{2
" call s:h("cssAttrComma", { "fg": s:purple._ })
" call s:h("cssAttributeSelector", { "fg": s:green._ })
call s:h("cssBraces", { "fg": s:fg.dark })
" call s:h("cssClassName", { "fg": s:yellow.dark })
" call s:h("cssClassNameDot", { "fg": s:yellow.dark })
" call s:h("cssDefinition", { "fg": s:purple._ })
" call s:h("cssFontAttr", { "fg": s:yellow.dark })
" call s:h("cssFontDescriptor", { "fg": s:purple._ })
" call s:h("cssFunctionName", { "fg": s:blue._ })
" call s:h("cssIdentifier", { "fg": s:blue._ })
" call s:h("cssImportant", { "fg": s:purple._ })
" call s:h("cssInclude", { "fg": s:white })
" call s:h("cssIncludeKeyword", { "fg": s:purple._ })
" call s:h("cssMediaType", { "fg": s:yellow.dark })
call s:h("cssProp", { "fg": s:fg._ })
" call s:h("cssPseudoClassId", { "fg": s:yellow.dark })
" call s:h("cssSelectorOp", { "fg": s:purple._ })
" call s:h("cssSelectorOp2", { "fg": s:purple._ })
" call s:h("cssTagName", { "fg": s:red._ })

" Elixir {{{2
call s:h("elixirAlias", "elixirModuleDeclaration") " aliased module names
call s:h("elixirBlock", "PreProc") " do, end, etc.
call s:h("elixirModuleDeclaration", "Constant") " module name definition
" call s:h("elixirStringDelimiter", "Special") " quotes, etc.
call s:h("elixirVariable", { "fg": s:blue.dim }) " module attributes

" HTML {{{2
call s:h("htmlTitle", { "fg": s:fg._ })
call s:h("htmlArg", "Identifier")
call s:h("htmlEndTag", "PreProc")
" call s:h("htmlH1", { "fg": s:fg._ })
call s:h("htmlLink", { "fg": s:purple.light })
call s:h("htmlSpecialChar", { "fg": s:yellow.light })
call s:h("htmlSpecialTagName", { "fg": s:red._ })
call s:h("htmlTag", "PreProc")
call s:h("htmlTagName", "Statement")

" JavaScript {{{2
" https://github.com/pangloss/vim-javascript
call s:h("jsArrowFunction", "Special")
" highlight jsBlock ctermfg=150
call s:h("jsClassKeywords", { "fg": s:purple._ })
call s:h("jsDocParam", { "fg": s:blue._ })
call s:h("jsDocTags", { "fg": s:purple._ })
call s:h("jsDot", "Operator")
" call s:h("jsExport", "PreProc")
" call s:h("jsExportDefault", "Type")
call s:h("jsFuncCall", "Statement")
" call s:h("jsFuncBraces", "Noise")
call s:h("jsFunction", "Special")
call s:h("jsGlobalObjects", "Constant")
call s:h("jsModuleWords", { "fg": s:purple._ })
call s:h("jsModules", { "fg": s:purple._ })
call s:h("jsNull", { "fg": s:yellow.dark })
call s:h("jsObjectKey", "Constant")
call s:h("jsOperator", "Operator")
call s:h("jsStorageClass", "StorageClass")
call s:h("jsTemplateBraces", { "fg": s:red.dark })
call s:h("jsTemplateVar", { "fg": s:green._ })
call s:h("jsThis", { "fg": s:red._ })
call s:h("jsUndefined", { "fg": s:yellow.dim_dark })
call s:h("jsVariableDef", "Identifier")
call s:h("jsxComponentName", "htmlTagName")
call s:h("jsxAttrib", "htmlArg")
call s:h("Noise", "PreProc")

" JSON {{{2
call s:h("jsonCommentError", { "fg": s:error })
call s:h("jsonKeyword", { "fg": s:red._ })
call s:h("jsonBoolean", { "fg": s:yellow.dark })
call s:h("jsonNumber", { "fg": s:yellow.dark })
call s:h("jsonQuote", { "fg": s:white })
call s:h("jsonMissingCommaError", { "fg": s:error, "gui": "reverse" })
call s:h("jsonNoQuotesError", { "fg": s:error, "gui": "reverse" })
call s:h("jsonNumError", { "fg": s:error, "gui": "reverse" })
call s:h("jsonString", { "fg": s:green._ })
call s:h("jsonStringSQError", { "fg": s:error, "gui": "reverse" })
call s:h("jsonSemicolonError", { "fg": s:error, "gui": "reverse" })

" ReasonML {{{2
call s:h("reasonConditional", "Conditional")
call s:h("reasonEnumVariant", "Type")
call s:h("reasonModPath", "Identifier")
call s:h("reasonTrait", "Identifier")
call s:h("reasonOperator", "Operator")
call s:h("reasonArrowCharacter", "Operator")

" SQL {{{2
call s:h("sqlKeyword", "Statement")

" TypeScript {{{2
call s:h("typescriptAliasDeclaration", "typescriptPredefinedType")
call s:h("typescriptAliasKeyword", "Special")
call s:h("typescriptArrowFunc", "Special")
call s:h("typescriptCall", "NONE")
call s:h("typescriptBraces", "PreProc")
call s:h("typescriptDestructureVariable", "Identifier")
call s:h("typescriptExport", "PreProc")
call s:h("typescriptFuncComma", "PreProc")
call s:h("typescriptFuncKeyword", "Special")
call s:h("typescriptObjectLabel", "Constant")
call s:h("typescriptObjectColon", "Special")
call s:h("typescriptMember", "Constant")
call s:h("typescriptParens", "PreProc")
call s:h("typescriptTypeAnnotation", "PreProc")
call s:h("typescriptTypeBrackets", "Special")
call s:h("typescriptTypeParameter", "typescriptPredefinedType")
call s:h("typescriptTypeReference", "typescriptPredefinedType")
call s:h("typescriptVariable", "PreProc")
call s:h("typescriptVariableDeclaration", "Identifier")


" vim {{{2
call s:h("vimLet", s:control_statement)
call s:h("vimFuncName", "Statement")
call s:h("vimOption", "Identifier")
" call s:h("vimUsrCmd", "vimCommand")

" XML {{{2
" call s:h("xmlAttrib", { "fg": s:yellow.dark })
" call s:h("xmlEndTag", { "fg": s:red._ })
" call s:h("xmlTag", { "fg": s:red._ })
" call s:h("xmlTagName", { "fg": s:red._ })

" sh {{{2
call s:h("shDerefVar", "shDerefSimple")

" systemd {{{2
call s:h('sdHeader', 'Title')
call s:h('sdUnitName', 'Type')
call s:h('sdEnvArg', 'Identifier')


" Git {{{2

" call s:h("gitcommitSummary", "Statement")
call s:h("gitcommitComment", "Comment")
call s:h("gitcommitUnmerged", { "fg": s:green._ })
call s:h("gitcommitOnBranch", {})
call s:h("gitcommitBranch", { "fg": s:purple._ })
call s:h("gitcommitDiscardedType", { "fg": s:red._ })
call s:h("gitcommitSelectedType", { "fg": s:green._ })
call s:h("gitcommitHeader", {})
call s:h("gitcommitUntrackedFile", { "fg": s:cyan._ })
call s:h("gitcommitDiscardedFile", { "fg": s:red._ })
call s:h("gitcommitSelectedFile", { "fg": s:green._ })
call s:h("gitcommitUnmergedFile", { "fg": s:yellow._ })
call s:h("gitcommitFile", {})
call s:h("gitcommitNoBranch", "gitcommitBranch")
call s:h("gitcommitUntracked", "gitcommitComment")
call s:h("gitcommitDiscarded", "gitcommitComment")
call s:h("gitcommitSelected", "gitcommitComment")
call s:h("gitcommitDiscardedArrow", "gitcommitDiscardedFile")
call s:h("gitcommitSelectedArrow", "gitcommitSelectedFile")
call s:h("gitcommitUnmergedArrow", "gitcommitUnmergedFile")

call s:h('gitmessengerHash', 'Identifier')


" Plugin Highlighting {{{1

" Telescope {{{2

" call s:h("TelescopeNormal", { "bg": s:black }) " Floating windows created by telescope
call s:h("TelescopeSelection", { "bg": s:bg.highlight, "cterm": "bold" }) " Selected item
call s:h("TelescopeSelectionCaret", { "fg": s:red.light }) " Selection caret
call s:h("TelescopeMultiSelection", { "bg": s:yellow.dim_dark }) " Multisections

" Border highlight groups
call s:h("TelescopeBorder", { "fg": s:fg.lessened })
call s:h("TelescopePromptBorder", { "fg": s:fg.lessened })
call s:h("TelescopeResultsBorder", { "fg": s:fg.lessened })
call s:h("TelescopePreviewBorder", { "fg": s:fg.lessened })

" Highlight characters your input matches
call s:h("TelescopeMatching", { "fg": s:cyan.dark })

" Color the prompt prefix
call s:h("TelescopePromptPrefix", { "fg": s:red.dim })

" ALE {{{2
" call s:h("ALEErrorSign", { "fg": s:red._ })

" lewis6991/gitsigns {{{2
call s:h("GitSignsAdd", { "fg": s:green._ })
call s:h("GitSignsChange", { "fg": s:yellow._ })
call s:h("GitSignsDelete", { "fg": s:red._ })
call s:h("GitSignsAddNr", { "fg": s:green._ })
call s:h("GitSignsChangeNr", { "fg": s:yellow._ })
call s:h("GitSignsDeleteNr", { "fg": s:red._ })
call s:h("GitSignsAddLn", { "bg": s:green.dim_dark })
call s:h("GitSignsChangeLn", { "bg": s:yellow.dim_dark })
call s:h("GitSignsDeleteLn", { "bg": s:red.dim_dark })

" tpope/vim-fugitive {{{2
call s:h("diffAdded", { "fg": s:green._ })
call s:h("diffRemoved", { "fg": s:red._ })
call s:h("fugitiveHeader", { "fg": s:red._ })
call s:h("fugitiveUntrackedHeading", "gitcommitUntrackedFile")
call s:h("fugitiveUnstagedHeading", { "fg": s:purple.light })
call s:h("fugitiveStagedHeading", "gitcommitSelectedFile")

" better-whitespace {{{2
call s:h("ExtraWhitespace", { "bg": s:red.dark })

" netrw {{{2
call s:h("netrwExe", { "fg": s:red._ })

" {{{2 lukas-reineke/indent-blankline.nvim
call s:h("IndentBlanklineChar", { "fg": { "cterm": 234 }})


" vim:foldmethod=marker:foldlevel=1:

