require('lazy').setup({
  'fladson/vim-kitty',
  {
    'knubie/vim-kitty-navigator',
    run = 'cp ./*.py ~/.config/kitty/',
    config = function() require('config.kitty-navigator') end,
  },

  { 'justinmk/vim-dirvish', config = function() require('config.dirvish') end },
  { 'mbbill/undotree', config = function() require('config.undotree') end },
  'tpope/vim-fugitive',
  { 'junegunn/gv.vim', config = function() require('config.gv') end },
  'stefandtw/quickfix-reflector.vim',
  'wsdjeg/vim-fetch',

  'nanotee/luv-vimdocs',
  'milisims/nvim-luaref',

  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('config.telescope') end,
  },
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    'nvim-telescope/telescope-github.nvim',
    config = function() require('config.telescope-github') end,
  },
  {
    'rlch/github-notifications.nvim',
    config = function() require('config.github-notifications') end,
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function() require('config.treesitter') end,
  },

  'exu/pgsql.vim',
  { 'preservim/vim-markdown', config = function() require('config.markdown') end }, -- included in polyglot but without extra features
  'habamax/vim-godot',
  { 'junegunn/limelight.vim', config = function() require('config.limelight') end },

  'neovim/nvim-lspconfig',
  { 'mfussenegger/nvim-lint', config = function() require('config.lint') end },
  { 'mhartington/formatter.nvim', config = function() require('config.formatter') end },
  { 'hrsh7th/nvim-cmp', config = function() require('config.cmp') end },
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-calc',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-cmdline',
  'petertriho/cmp-git',
  'onsails/lspkind-nvim',
  'kristijanhusak/vim-dadbod-completion',
  {
    'L3MON4D3/LuaSnip',
    config = function() require('snippets') end,
  },
  'saadparwaiz1/cmp_luasnip',

  { 'mickael-menu/zk-nvim', config = function() require('config.zk') end },

  {
    'kana/vim-textobj-user',
    dependencies = {
      'kana/vim-textobj-entire', -- ae/ie for entire file
      'kana/vim-textobj-indent', -- ai/ii for indent block
      'kana/vim-textobj-line', -- al/il for line
      'sgur/vim-textobj-parameter', -- a,/i, for argument/parameter
      'Julian/vim-textobj-variable-segment', -- av/iv for variable part
      'Chun-Yang/vim-textobj-chunk', -- ac/ic for json-ish chunk
      'whatyouhide/vim-textobj-xmlattr', -- ax/ix for xml attribute
    },
  },

  { 'tpope/vim-dispatch', config = function() require('config.dispatch') end },
  {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = { 'markdown' },
    cmd = 'MarkdownPreview',
    config = function() require('config.markdown-preview') end,
  },
  'godlygeek/tabular',
  'chrisbra/csv.vim',
  'junegunn/vim-peekaboo',
  { 'rest-nvim/rest.nvim', config = function() require('config.rest') end },
  'wesQ3/vim-windowswap',

  'itchyny/lightline.vim',
  { 'lewis6991/gitsigns.nvim', config = function() require('config.gitsigns') end },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
    config = function() require('config.indent-blankline') end,
  },
  'ap/vim-css-color',
  'aoswalt/xterm-color-table.vim',

  { 'Raimondi/delimitMate', config = function() require('config.delimitmate') end },
  {
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
  },
  {
    'ntpeters/vim-better-whitespace',
    config = function() require('config.better-whitespace') end,
  },
  'tpope/vim-repeat',
  'tpope/vim-unimpaired',
  { 'kylechui/nvim-surround', config = function() require('config.surround') end },
  'tpope/vim-abolish',
  'tpope/vim-speeddating',
  { 'windwp/nvim-autopairs', config = function() require('config.autopairs') end },
  { 'windwp/nvim-ts-autotag', config = function() require('config.autotag') end },
  'tpope/vim-dadbod',
}, {
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
})
