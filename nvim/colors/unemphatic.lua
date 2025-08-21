vim.g.colors_name = 'unemphatic'

vim.api.nvim_exec(
  [[
  highlight clear
  syntax reset
  set t_Co=256
]],
  false
)

vim.o.background = 'dark'

vim.o.conceallevel = 2

local function link(from, to) vim.api.nvim_set_hl(0, from, { link = to }) end

local clear_style = {
  fg = 'NONE',
  bg = 'NONE',
  style = 'NONE',
  guifg = 'NONE',
  guibg = 'NONE',
  gui = 'NONE',
  guisp = 'NONE',
}

local keymap = {
  fg = 'ctermfg',
  bg = 'ctermbg',
  style = 'cterm',
}

-- vim.api.nvim_set_hl(0, 'TSVariable', { bg = '#123657', underdot = true })
-- vim.api.nvim_set_hl(0, 'TSVariable', { link = 'TSFunction' })
-- h synIDattr()

local function highlight(group, style)
  style = vim.tbl_extend('force', clear_style, style)

  local strings = {}
  for k, v in pairs(style) do
    k = keymap[k] or k
    v = v or 'NONE'

    table.insert(strings, k .. '=' .. v)
  end

  local combined = table.concat(strings, ' ')

  vim.api.nvim_command('highlight! ' .. group .. ' ' .. combined)
end

local function expand_style(style)
  local fg = style.fg or {}
  local bg = style.bg or {}
  style = style.style or 'NONE'
  local guisp = style.guisp or 'NONE'

  return {
    fg = fg.term or 'NONE',
    bg = bg.term or 'NONE',
    style = style,
    guifg = (fg.gui and '#' .. fg.gui) or 'NONE',
    guibg = (bg.gui and '#' .. bg.gui) or 'NONE',
    gui = style,
    guisp = guisp,
  }
end

local function h(group, style_or_group)
  if type(style_or_group) == 'table' then
    local style = expand_style(style_or_group)
    highlight(group, style)
  else
    link(group, style_or_group)
  end
end

-- {{{ Colors
local colors = {
  red = {
    [-1] = { term = 210, gui = 'ff8787' },
    [0] = { term = 203, gui = 'ff5f5f' },
    [1] = { term = 196, gui = 'ff0000' },
    [2] = { term = 124, gui = 'af0000' },
    [3] = { term = 52, gui = '5f0000' },
  },
  orange = {
    [-1] = { term = 223, gui = 'ffd7af' },
    [0] = { term = 215, gui = 'ffaf5f' },
    [1] = { term = 208, gui = 'ff8700' },
    [2] = { term = 130, gui = 'af5f00' },
    [3] = { term = 94, gui = '875f00' },
  },
  green = {
    [-1] = { term = 157, gui = 'afffaf' },
    [0] = { term = 120, gui = '87ff87' },
    [1] = { term = 34, gui = '00af00' },
    [2] = { term = 70, gui = '5faf00' },
    [3] = { term = 22, gui = '005f00' },
  },
  yellow = {
    [-1] = { term = 229, gui = 'ffffaf' },
    [0] = { term = 228, gui = 'ffff87' },
    [1] = { term = 220, gui = 'ffd700' },
    [2] = { term = 142, gui = 'afaf00' },
    [3] = { term = 100, gui = '878700' },
  },
  blue = {
    [-1] = { term = 117, gui = '87d7ff' },
    [0] = { term = 39, gui = '00afff' },
    [1] = { term = 27, gui = '005fff' },
    [2] = { term = 25, gui = '005faf' },
    [3] = { term = 20, gui = '0000d7' },
  },
  purple = {
    [-1] = { term = 219, gui = 'ffafff' },
    [0] = { term = 170, gui = 'd75fd7' },
    [1] = { term = 135, gui = 'af5fff' },
    [2] = { term = 90, gui = '870087' },
    [3] = { term = 55, gui = '5f00af' },
  },
  cyan = {
    [-1] = { term = 159, gui = 'afffff' },
    [0] = { term = 44, gui = '00d7d7' },
    [1] = { term = 37, gui = '00afaf' },
    [2] = { term = 30, gui = '008787' },
    [3] = { term = 23, gui = '005f5f' },
  },
  grayscale = {
    [0] = { term = 15, gui = 'ffffff' },
    [1] = { term = 251, gui = 'c6c6c6' },
    [2] = { term = 247, gui = '9e9e9e' },
    [3] = { term = 244, gui = '808080' },
    [4] = { term = 239, gui = '4e4e4e' },
    [5] = { term = 238, gui = '444444' },
    [6] = { term = 235, gui = '262626' },
    [7] = { term = 234, gui = '1c1c1c' },
    [8] = { term = 233, gui = '121212' },
    [9] = { term = 232, gui = '080808' },
    [10] = { term = 0, gui = '000000' },
  },
  none = { term = 'NONE', gui = 'NONE' },
}

local other_colors = {
  active_grey = { term = 245, gui = '8a8a8a' },
  inactive_grey = { term = 236, gui = '303030' },
  menu_selection = { term = 25, gui = '005faf' },
  quote = { term = 62, gui = '9e9ebe' },
}

local white = colors.grayscale[0]
local black = colors.grayscale[10]
-- }}}

-- {{{ Styles
local styles = {
  error = { fg = colors.red[1] },
  comment = { fg = colors.grayscale[4], style = 'italic' },
  control_statement = { fg = colors.blue[2] },
  fg_offset = { fg = colors.grayscale[1] },
  fg_lessened = { fg = colors.grayscale[2] },
  fg_dark = { fg = colors.grayscale[3] },
  fg_minimum = { fg = colors.grayscale[4] },
  bg_offset = { bg = colors.grayscale[9] },
  bg_highlight = { bg = colors.grayscale[6] },
  bg_dark = { bg = colors.grayscale[7] },
  bg_minimum = { bg = colors.grayscale[8] },
  active_grey = { fg = other_colors.active_grey },
  inactive_grey = { fg = other_colors.inactive_grey },
  menu_selection = { bg = other_colors.menu_selection },
  quote = { fg = other_colors.quote, style = 'italic' },
  codelens = { fg = colors.grayscale[2], style = 'italic' },
}
-- }}}

-- Syntax Groups (descriptions and ordering from `:h w18`) {{{1
h('Comment', styles.comment) -- any comment
-- h("Comment", { fg = styles.fg_minimum, style = "italic" }) -- any comment
h('Constant', { fg = colors.orange[-1] }) -- any constant
h('String', { fg = colors.yellow[-1] }) -- a string constant = "this is a string"
-- h("Character", "Constant") -- a character constant = 'c', '\n'
h('Number', { fg = colors.orange[1] }) -- a number constant = 234, 0xff
h('Boolean', 'Number') -- a boolean constant = TRUE, false
h('Float', 'Number') -- a floating point constant = 2.3e10
h('Identifier', { fg = colors.cyan[-1] }) -- any variable name
-- h("Function", "Identifier") -- function name (also = methods for classes)
h('Statement', { fg = colors.blue[-1] }) -- any statement
h('Conditional', styles.control_statement) -- if, then, else, endif, switch, etc.
h('Repeat', styles.control_statement) -- for, do, while, etc.
h('Label', styles.control_statement) -- case, default, etc.
h('Operator', { fg = colors.blue[-1] }) -- 'sizeof', '+', '*', etc.
-- h("Keyword", "Statement") -- any other keyword
h('Exception', { fg = colors.red[2] }) -- try, catch, throw
h('PreProc', styles.fg_minimum) -- generic Preprocessor
-- h("Include", "PreProc") -- preprocessor #include
-- h("Define", "PreProc") -- preprocessor #define
-- h("Macro", "Define") -- same as Define
-- h("PreCondit", "PreProc") -- preprocessor #if, #else, #endif, etc.
h('Type', { fg = colors.red[-1] }) -- int, long, char, etc.
h('StorageClass', styles.fg_minimum) -- static, register, volatile, etc.
-- h("Structure", "Type") -- struct, union, enum, etc.
-- h("Typedef", "Type") -- A typedef
h('Special', styles.fg_offset) -- any special symbol
-- h("SpecialChar", "Special") -- special character in a constant
-- h("Tag", "Special") -- you can use CTRL-] on this
h('Delimiter', styles.fg_lessened) -- character that needs attention
-- h("SpecialComment", "Special") -- special things inside a comment
h('Debug', 'Special') -- debugging statements
h('Underlined', { style = 'underline' }) -- text that stands out, HTML links
-- h("Ignore", {}) -- left blank, hidden
h('Error', styles.error) -- any erroneous construct
h('Warning', { fg = colors.yellow[1] })
h('Todo', { fg = colors.purple[0] }) -- anything that needs extra attention; mostly the keywords TODO and XXX

h('LspCodeLens', styles.codelens)

h('@markup.heading', { fg = colors.green[-1], style = 'bold' })
h('@markup.strong.markdown_inline', { style = 'bold' })
h('@markup.italic.markdown_inline', { style = 'italic' })
h('@markup.raw.markdown_inline', '@symbol')
h('@markup.raw.delimiter.markdown_inline', '@conceal')
h('@markup.link.label.markdown_inline', 'Identifier')
h('@text.title', 'Title')
h('@text.note', 'Todo')
h('@text.warning', 'Warning')
h('@text.danger', 'Error')
h('@text.literal.block.markdown', 'NONE')
h('@text.strong', { style = 'bold' })
h('@text.strong', { style = 'bold' })
h('@text.emphasis', { style = 'italic' })
h('@constant.builtin', 'Constant')
h('@parameter', 'Variable')
-- h('elixirTSParameter', '@symbol')
h('@variable', 'Variable')
h('@keyword', 'Keyword')
-- h('@keyword', 'PreProc')
h('@keyword.function', 'PreProc')
h('@symbol', 'Constant')
-- h("elixirTSType", "Constant")
h('@field', 'NONE')
h('bashTSParameter', 'NONE')
h('@attribute', { fg = colors.purple[2] })
h('@module', 'Type')
h('@string.special', 'Constant')
h('@variable', 'Variable')
h('@variable.member', 'Identifier')
h('@comment.todo', 'Todo')

-- Highlighting Groups (descriptions and ordering from `:h hitest.vim`) {{{1

h('ColorColumn', styles.bg_offset) -- used for the columns set with 'colorcolumn'
h("Conceal", { fg = colors.grayscale[2], bg = colors.grayscale[8] }) -- placeholder characters substituted for concealed text (see 'conceallevel')
h('Cursor', { fg = colors.none, bg = colors.blue[0] }) -- the character under the cursor
-- h("CursorIM", {}) -- like Cursor, but used when in IME mode
h('CursorColumn', styles.bg_highlight) -- the screen column that the cursor is in when 'cursorcolumn' is set
h('CursorLine', 'CursorColumn') -- the screen line that the cursor is in when 'cursorline' is set
h('Directory', { fg = colors.blue[0] }) -- directory names (and other special names in listings)
h('DiffAdd', styles.bg_dark) -- diff mode = Added line
h('DiffChange', styles.bg_dark) -- diff mode = Changed line
h('DiffDelete', { fg = colors.red[0] }) -- diff mode = Deleted line
h('DiffText', { fg = colors.yellow[0], bg = colors.visual_grey }) -- diff mode = Changed text within a changed line
-- h("EndOfBuffer", {}) -- filler lines (~) after the end of the buffer
-- h("TermCursor", {}) -- cursor in a focused terminal
-- h("TermCursorNC", {}) -- cursor in an unfocused terminal
h('ErrorMsg', 'Error') -- error messages on the command line
h('VertSplit', { fg = white }) -- the column separating vertically split windows
h('Folded', styles.fg_minimum) -- line used for closed folds
h('FoldColumn', {}) -- 'foldcolumn'
h('SignColumn', {}) -- column where signs are displayed
h('IncSearch', { fg = black, bg = colors.yellow[2] }) -- 'incsearch' highlighting; also used for the text replaced with ' =s///c'
-- h("Substitute", {}) --  =substitute replacement text highlighting
h('LineNr', styles.fg_minimum) -- Line number for ' =number' and ' =#' commands, and when 'number' or 'relativenumber' option is set.
h('CursorLineNr', {}) -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
h('MatchParen', { fg = colors.blue[0] }) -- The character under the cursor or just before it, if it is a paired[0] bracket, and its match.
h('ModeMsg', {}) -- 'showmode' message (e.g., '-- INSERT --')
-- h("MsgArea", {}) -- Area for messages and cmdline
-- h("MsgSeparator", {}) -- Separator for scrolled messages, `msgsep` flag of 'display'
h('MoreMsg', {}) -- more-prompt
h('NonText', styles.fg_minimum) -- '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., '>' displayed when a double-wide character doesn't fit at the end of the line).
h('Normal', {}) -- normal text
h("NormalFloat", { bg = colors.grayscale[9] }) -- normal text in floating windows
h('NormalNC', styles.bg_minimum) -- normal text in non-current windows
h('Pmenu', styles.bg_dark) -- Popup menu = normal item.
h('PmenuSel', styles.menu_selection) -- Popup menu = selected item.
h('PmenuSbar', styles.fg_dark) -- Popup menu = scrollbar.
h('PmenuThumb', { bg = white }) -- Popup menu = Thumb of the scrollbar.
h('Question', { fg = colors.purple[0] }) -- hit-enter prompt and yes/no questions
-- h("QuickFixLine", {}) -- Current quickfix item in the quickfix window. Combined with hl-CursorLine when the cursor is there
h('Search', { fg = black, bg = colors.yellow[2] }) -- Last search pattern highlighting (see 'hlsearch'). Also used for highlighting the current line in the quickfix window and similar items that need to stand out.
h('SpecialKey', styles.fg_dark) -- Meta and special keys listed with ' =map', also for text used to show unprintable characters in the text, 'listchars'. Generally = text that is displayed differently from what it really is.
h('SpellBad', { fg = colors.red[1], style = 'underline' }) -- Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
h('SpellCap', 'Warning') -- Word that should start with a capital. This will be combined with the highlighting used otherwise.
h('SpellLocal', 'Warning') -- Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
h('SpellRare', 'Warning') -- Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
h('StatusLine', { fg = black, bg = other_colors.active_grey }) -- status line of current window
h('StatusLineNC', { fg = white, bg = other_colors.inactive_grey }) -- status lines of not-current windows Note = if this is equal to 'StatusLine' Vim will use '^^^' in the status line of the current window.
h('TabLine', styles.fg_minimum) -- tab pages line, not active tab page label
h('TabLineFill', {}) -- tab pages line, where there are no labels
h('TabLineSel', { fg = white }) -- tab pages line, active tab page label
h('Title', { fg = colors.green[-1] }) -- titles for output from ' =set all', ' =autocmd' etc.
h('Visual', styles.bg_highlight) -- Visual mode selection
h('VisualNOS', styles.fg_minimum) -- Visual mode selection when vim is 'Not Owning the Selection'. Only X11 Gui's gui-x11 and xterm-clipboard supports this.
h('WarningMsg', 'Warning') -- warning messages
-- h("Whitespace", {}) -- 'nbsp', 'space', 'tab' and 'trail' in 'listchars'
h('WildMenu', {}) -- current match in 'wildmenu' completion

-- Syntax highlighting groups {{{2

h('RedrawDebugClear', { fg = black, bg = colors.yellow[1] })
h('RedrawDebugComposed', { fg = black, bg = colors.green[1] })
h('NvimInternalError', { fg = white, bg = colors.red[1] })

-- Language-Specific highlighting {{{1

-- CSS {{{2
-- h("cssAttrComma", { fg = colors.purple[0] })
-- h("cssAttributeSelector", { fg = colors.green[0] })
h('cssBraces', styles.fg_dark)
-- h("cssClassName", { fg = colors.yellow[1] })
-- h("cssClassNameDot", { fg = colors.yellow[1] })
-- h("cssDefinition", { fg = colors.purple[0] })
-- h("cssFontAttr", { fg = colors.yellow[1] })
-- h("cssFontDescriptor", { fg = colors.purple[0] })
-- h("cssFunctionName", { fg = colors.blue[0] })
-- h("cssIdentifier", { fg = colors.blue[0] })
-- h("cssImportant", { fg = colors.purple[0] })
-- h("cssInclude", { fg = white })
-- h("cssIncludeKeyword", { fg = colors.purple[0] })
-- h("cssMediaType", { fg = colors.yellow[1] })
h('cssProp', { fg = colors.white })
-- h("cssPseudoClassId", { fg = colors.yellow[1] })
-- h("cssSelectorOp", { fg = colors.purple[0] })
-- h("cssSelectorOp2", { fg = colors.purple[0] })
-- h("cssTagName", { fg = colors.red[0] })

-- Elixir {{{2
-- h('elixirAlias', 'elixirModuleDeclaration') -- aliased module names
-- h('elixirBlock', 'PreProc') -- do, end, etc.
-- h('elixirModuleDeclaration', 'Constant') -- module name definition
-- h("elixirStringDelimiter", "Special") -- quotes, etc.
-- h('elixirVariable', { fg = colors.blue[2] }) -- module attributes

-- HTML {{{2
h('htmlTitle', { fg = colors.white })
h('htmlArg', 'Identifier')
h('htmlEndTag', 'PreProc')
-- h("htmlH1", { fg = colors.white })
h('htmlLink', { fg = colors.purple[-1] })
h('htmlSpecialChar', { fg = colors.yellow[-1] })
h('htmlSpecialTagName', { fg = colors.red[0] })
h('htmlTag', 'PreProc')
h('htmlTagName', 'Statement')

-- JavaScript {{{2
-- httpcolors.//github.com/pangloss/vim-javascript
h('jsArrowFunction', 'Special')
-- highlight jsBlock ctermfg=150
h('jsClassKeywords', { fg = colors.purple[0] })
h('jsDocParam', { fg = colors.blue[0] })
h('jsDocTags', { fg = colors.purple[0] })
h('jsDot', 'Operator')
-- h("jsExport", "PreProc")
-- h("jsExportDefault", "Type")
h('jsFuncCall', 'Statement')
-- h("jsFuncBraces", "Noise")
h('jsFunction', 'Special')
h('jsGlobalObjects', 'Constant')
h('jsModuleWords', { fg = colors.purple[0] })
h('jsModules', { fg = colors.purple[0] })
h('jsNull', { fg = colors.yellow[1] })
h('jsObjectKey', 'Constant')
h('jsOperator', 'Operator')
h('jsStorageClass', 'StorageClass')
h('jsTemplateBraces', { fg = colors.red[1] })
h('jsTemplateVar', { fg = colors.green[0] })
h('jsThis', { fg = colors.red[0] })
h('jsUndefined', { fg = colors.yellow[3] })
h('jsVariableDef', 'Identifier')
h('jsxComponentName', 'htmlTagName')
h('jsxAttrib', 'htmlArg')
h('Noise', 'PreProc')

-- JSON {{{2
h('jsonCommentError', 'Error')
h('jsonKeyword', { fg = colors.red[0] })
h('jsonBoolean', { fg = colors.yellow[1] })
h('jsonNumber', { fg = colors.yellow[1] })
h('jsonQuote', { fg = white })
h('jsonMissingCommaError', { fg = colors.red[1], style = 'reverse' })
h('jsonNoQuotesError', { fg = colors.red[1], style = 'reverse' })
h('jsonNumError', { fg = colors.red[1], style = 'reverse' })
h('jsonString', { fg = colors.green[0] })
h('jsonStringSQError', { fg = colors.red[1], style = 'reverse' })
h('jsonSemicolonError', { fg = colors.red[1], style = 'reverse' })

-- SQL {{{2
h('sqlKeyword', 'Statement')

-- TypeScript {{{2
h('typescriptAliasDeclaration', 'typescriptPredefinedType')
h('typescriptAliasKeyword', 'Special')
h('typescriptArrowFunc', 'Special')
h('typescriptCall', 'NONE')
h('typescriptBraces', 'PreProc')
h('typescriptDestructureVariable', 'Identifier')
h('typescriptExport', 'PreProc')
h('typescriptFuncComma', 'PreProc')
h('typescriptFuncKeyword', 'Special')
h('typescriptObjectLabel', 'Constant')
h('typescriptObjectColon', 'Special')
h('typescriptMember', 'Constant')
h('typescriptParens', 'PreProc')
h('typescriptTypeAnnotation', 'PreProc')
h('typescriptTypeBrackets', 'Special')
h('typescriptTypeParameter', 'typescriptPredefinedType')
h('typescriptTypeReference', 'typescriptPredefinedType')
h('typescriptVariable', 'PreProc')
h('typescriptVariableDeclaration', 'Identifier')

-- vim {{{2
h('vimLet', styles.control_statement)
h('vimFuncName', 'Statement')
h('vimOption', 'Identifier')
-- h("vimUsrCmd", "vimCommand")
h('helpExample', styles.quote)
h('helpCommand', styles.quote)

-- XML {{{2
-- h("xmlAttrib", { fg = colors.yellow[1] })
-- h("xmlEndTag", { fg = colors.red[0] })
-- h("xmlTag", { fg = colors.red[0] })
-- h("xmlTagName", { fg = colors.red[0] })

-- sh {{{2
h('shDerefVar', 'shDerefSimple')

-- systemd {{{2
h('sdHeader', 'Title')
h('sdUnitName', 'Type')
h('sdEnvArg', 'Identifier')

-- Git {{{2

-- h("gitcommitSummary", "Statement")
h('gitcommitComment', 'Comment')
h('gitcommitUnmerged', { fg = colors.green[0] })
h('gitcommitOnBranch', 'NONE')
h('gitcommitBranch', { fg = colors.purple[0] })
h('gitcommitDiscardedType', { fg = colors.red[0] })
h('gitcommitSelectedType', { fg = colors.green[0] })
h('gitcommitHeader', {})
h('gitcommitUntrackedFile', { fg = colors.cyan[0] })
h('gitcommitDiscardedFile', { fg = colors.red[0] })
h('gitcommitSelectedFile', { fg = colors.green[0] })
h('gitcommitUnmergedFile', { fg = colors.yellow[0] })
h('gitcommitFile', {})
h('gitcommitNoBranch', 'gitcommitBranch')
h('gitcommitUntracked', 'gitcommitComment')
h('gitcommitDiscarded', 'gitcommitComment')
h('gitcommitSelected', 'gitcommitComment')
h('gitcommitDiscardedArrow', 'gitcommitDiscardedFile')
h('gitcommitSelectedArrow', 'gitcommitSelectedFile')
h('gitcommitUnmergedArrow', 'gitcommitUnmergedFile')

h('gitmessengerHash', 'Identifier')

-- Markdown {{{2

h('mkdBlockQuote', styles.quote)

-- Plugin highlighting {{{1

-- Telescope {{{2

-- h("TelescopeNormal", { bg = black }) -- Floating windows created by telescope
h('TelescopeSelection', styles.bg_highlight) -- Selected item
-- h("TelescopeSelection", { bg = styles.bg_highlight, style = "bold" }) -- Selected item
h('TelescopeSelectionCaret', { fg = colors.red[-1] }) -- Selection caret
h('TelescopeMultiSelection', { bg = colors.yellow[3] }) -- Multisections

-- Border highlight groups
h('TelescopeBorder', styles.fg_lessened)
h('TelescopePromptBorder', styles.fg_lessened)
h('TelescopeResultsBorder', styles.fg_lessened)
h('TelescopePreviewBorder', styles.fg_lessened)

-- highlight characters your input matches
h('TelescopeMatching', { fg = colors.cyan[1] })

-- Color the prompt prefix
h('TelescopePromptPrefix', { fg = colors.red[2] })

-- lewis6991/gitsigns {{{2
h('GitSignsAdd', { fg = colors.green[0] })
h('GitSignsChange', { fg = colors.yellow[0] })
h('GitSignsDelete', { fg = colors.red[0] })
h('GitSignsAddNr', { fg = colors.green[0] })
h('GitSignsChangeNr', { fg = colors.yellow[0] })
h('GitSignsDeleteNr', { fg = colors.red[0] })
h('GitSignsAddLn', { bg = colors.green[3] })
h('GitSignsChangeLn', { bg = colors.yellow[3] })
h('GitSignsDeleteLn', { bg = colors.red[3] })

-- tpope/vim-fugitive {{{2
h('diffAdded', { fg = colors.green[0] })
h('diffRemoved', { fg = colors.red[0] })
h('fugitiveHeader', { fg = colors.red[0] })
h('fugitiveUntrackedHeading', 'gitcommitUntrackedFile')
h('fugitiveUnstagedHeading', { fg = colors.purple[-1] })
h('fugitiveStagedHeading', 'gitcommitSelectedFile')

-- better-whitespace {{{2
h('ExtraWhitespace', { bg = colors.red[1] })


-- {{{2 lukas-reineke/indent-blankline.nvim
h('IblIndent', { fg = colors.grayscale[7] })

-- vim:foldmethod=marker:foldlevel=1:
