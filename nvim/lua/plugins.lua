require('packer').startup({
  function(use)
    use('wbthomason/packer.nvim')

    use({ 'nathom/tmux.nvim', config = [[require('config.tmux')]] })

    use({ 'justinmk/vim-dirvish', config = [[require('config.dirvish')]] })
    use({ 'simnalamburt/vim-mundo', config = [[require('config.mundo')]] })
    use('tpope/vim-fugitive')
    use({ 'junegunn/gv.vim', config = [[require('config.gv')]] })
    use('stefandtw/quickfix-reflector.vim')
    use('wsdjeg/vim-fetch')

    use('nvim-lua/plenary.nvim')
    use({
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = [[require('config.telescope')]],
    })
    use({ 'nvim-telescope/telescope-github.nvim', config = [[require('config.telescope-github')]] })
    use({
      'rlch/github-notifications.nvim',
      config = [[require('config.github-notifications')]],
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
      },
    })

    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = [[require('config.treesitter')]],
    })
    use('nvim-treesitter/playground')

    use({ 'sheerun/vim-polyglot', config = [[require('config.polyglot')]] })
    use('exu/pgsql.vim')
    use({ 'preservim/vim-markdown', config = [[require('config.markdown')]] }) -- included in polyglot but without extra features
    use('habamax/vim-godot')
    use({ 'junegunn/limelight.vim', config = [[require('config.limelight')]] })

    use('neovim/nvim-lspconfig')
    use({ 'jose-elias-alvarez/null-ls.nvim', branch = 'main', config = [[require('config.null-ls')]] })
    use({ 'jose-elias-alvarez/nvim-lsp-ts-utils', branch = 'main' })
    use({ 'hrsh7th/nvim-cmp', branch = 'main', config = [[require('config.cmp')]] })
    use({ 'hrsh7th/cmp-buffer', branch = 'main' })
    use({ 'hrsh7th/cmp-path', branch = 'main' })
    use({ 'hrsh7th/cmp-calc', branch = 'main' })
    use({ 'hrsh7th/cmp-nvim-lsp', branch = 'main' })
    use({ 'hrsh7th/cmp-nvim-lua', branch = 'main' })
    use({ 'hrsh7th/cmp-cmdline', branch = 'main' })
    use('onsails/lspkind-nvim')
    use('kristijanhusak/vim-dadbod-completion')
    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')

    use('kana/vim-textobj-user')
    use('kana/vim-textobj-entire') -- ae/ie for entire file
    use('kana/vim-textobj-indent') -- ai/ii for indent block
    use('kana/vim-textobj-line') -- al/il for line
    use('sgur/vim-textobj-parameter') -- a,/i, for argument/parameter
    use('Julian/vim-textobj-variable-segment') -- av/iv for variable part
    use('Chun-Yang/vim-textobj-chunk') -- ac/ic for json-ish chunk
    use('whatyouhide/vim-textobj-xmlattr') -- ax/ix for xml attribute

    use({ 'tpope/vim-dispatch', config = [[require('config.dispatch')]] })
    use({
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      ft = { 'markdown' },
      cmd = 'MarkdownPreview',
      config = [[require('config.markdown-preview')]],
    })
    use('godlygeek/tabular')
    use('chrisbra/csv.vim')
    use('junegunn/vim-peekaboo')
    use({ 'diepm/vim-rest-console', config = [[require('config.rest-console')]] })
    use('wesQ3/vim-windowswap')

    use('itchyny/lightline.vim')
    use({ 'lewis6991/gitsigns.nvim', branch = 'main', config = [[require('config.gitsigns')]] })
    use({ 'lukas-reineke/indent-blankline.nvim', config = [[require('config.indent-blankline')]] })
    use('ap/vim-css-color')
    use('aoswalt/xterm-color-table.vim')

    use({ 'Raimondi/delimitMate', config = [[require('config.delimitmate')]] })
    use({
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup()
      end,
    })
    use({ 'ntpeters/vim-better-whitespace', config = [[require('config.better-whitespace')]] })
    use('tpope/vim-repeat')
    use('tpope/vim-unimpaired')
    use({ 'tpope/vim-surround', config = [[require('config.surround')]] })
    use('tpope/vim-abolish')
    use('tpope/vim-scriptease')
    use('tpope/vim-speeddating')
    use('tpope/vim-endwise')
    use('tpope/vim-rsi')
    use('tpope/vim-dadbod')

    -- from main init
    if packer_bootstrap then -- luacheck: globals packer_bootstrap
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_cmd = 'leftabove 75vnew \\[packer\\]',
    },
  },
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
