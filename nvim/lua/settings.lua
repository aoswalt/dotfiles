vim.cmd.colorscheme('unemphatic')

vim.opt.swapfile = false
vim.opt.number = true -- line numbers
vim.opt.cursorline = true -- highlight cursorline
vim.opt.scrolloff = 4 -- keep more lines on screen while scrolling
vim.opt.sidescrolloff = 5 -- horizontal scrolloff
vim.opt.list = true -- enable invisible characters
vim.opt.wrap = false -- do not wrap lines by default
vim.opt.mouse = 'a' -- use mouse in all modes

vim.opt.tabstop = 2 -- width of tabs
vim.opt.shiftwidth = 2 -- amount for < and > commands
vim.opt.shiftround = true -- indent to the next multiple of shiftwidth
vim.opt.expandtab = true -- insert spaces instead of tabs

vim.opt.splitbelow = true -- default horizontal split to lower
vim.opt.splitright = true -- default vertical split to right

vim.opt.ignorecase = true -- ignore caps when searching
vim.opt.smartcase = true -- unless a capital is used
vim.opt.infercase = true -- smart auto-completion casing
vim.opt.wildignorecase = true -- ignore case on files and directories
vim.opt.gdefault = true -- global search by default
vim.opt.lazyredraw = true -- no need to redraw all the time
vim.opt.hlsearch = false -- don't highlight searches by default
vim.opt.path:append({ '**' }) -- include subdirectory globbing in path for :find
vim.opt.diffopt:append({ 'internal' }) -- internal library for performance
vim.opt.diffopt:append({ 'vertical' }) -- vertical split for diffs

vim.opt.showmode = false -- do not show mode since using lightline

-- characters for horizontal scrolled text
vim.opt.listchars:append({
  extends = '»',
  precedes = '«',
  nbsp = '⣿',
})

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

if vim.fn.executable('rg') then
  vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden'
  vim.opt.grepformat = '%f:%l:%c:%m'
end

vim.opt.shortmess:append({
  c = true, -- Do not show completion messages in command line
})

vim.g.mapleader = ' ' -- use space as leader

if vim.fn.isdirectory(vim.fn.expand('$HOME/.config/nvim/undo')) == 0 then
  vim.cmd([[silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1]])
end
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.config/nvim/undo/')

-- highlight line 80 and 120+
vim.opt.colorcolumn = '80,' .. vim.fn.join(vim.fn.range(120, 999), ',')

-- use %% for local relative paths
vim.cmd([[cabbrev <expr> %% expand('%:p:h')]])

-- override $VISUAL to use nvr inside neovim
if vim.fn.executable('nvr') then
  vim.env.VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end
