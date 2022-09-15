require('packer').startup({
  function(use)
    use('wbthomason/packer.nvim')

    use('fladson/vim-kitty')
    use({
      'knubie/vim-kitty-navigator',
      run = 'cp ./*.py ~/.config/kitty/',
      config = function() require('config.kitty-navigator') end,
    })

    use({ 'justinmk/vim-dirvish', config = function() require('config.dirvish') end })
    use({ 'mbbill/undotree', config = function() require('config.undotree') end })
    use('tpope/vim-fugitive')
    use({ 'junegunn/gv.vim', config = function() require('config.gv') end })
    use('stefandtw/quickfix-reflector.vim')
    use('wsdjeg/vim-fetch')

    use('nanotee/luv-vimdocs')
    use('milisims/nvim-luaref')

    use('nvim-lua/plenary.nvim')
    use({
      'nvim-telescope/telescope.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function() require('config.telescope') end,
    })
    use({ 'nvim-telescope/telescope-ui-select.nvim' })
    use({
      'nvim-telescope/telescope-github.nvim',
      config = function() require('config.telescope-github') end,
    })
    use({
      'rlch/github-notifications.nvim',
      config = function() require('config.github-notifications') end,
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
      },
    })

    use({
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = function() require('config.treesitter') end,
    })
    use('nvim-treesitter/playground')

    use({ 'sheerun/vim-polyglot', config = function() require('config.polyglot') end })
    use('exu/pgsql.vim')
    use({ 'preservim/vim-markdown', config = function() require('config.markdown') end }) -- included in polyglot but without extra features
    use('habamax/vim-godot')
    use({ 'junegunn/limelight.vim', config = function() require('config.limelight') end })

    use('neovim/nvim-lspconfig')
    use({ 'mfussenegger/nvim-lint', config = function() require('config.lint') end })
    use({ 'mhartington/formatter.nvim', config = function() require('config.formatter') end })
    use({ 'hrsh7th/nvim-cmp', config = function() require('config.cmp') end })
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-calc')
    use('hrsh7th/cmp-nvim-lsp')
    use('hrsh7th/cmp-nvim-lua')
    use('hrsh7th/cmp-cmdline')
    use('petertriho/cmp-git')
    use('onsails/lspkind-nvim')
    use('kristijanhusak/vim-dadbod-completion')
    use({
      'L3MON4D3/LuaSnip',
      config = function() require('snippets') end,
    })
    use('saadparwaiz1/cmp_luasnip')

    use({ 'mickael-menu/zk-nvim', config = function() require('config.zk') end })

    use('kana/vim-textobj-user')
    use('kana/vim-textobj-entire') -- ae/ie for entire file
    use('kana/vim-textobj-indent') -- ai/ii for indent block
    use('kana/vim-textobj-line') -- al/il for line
    use('sgur/vim-textobj-parameter') -- a,/i, for argument/parameter
    use('Julian/vim-textobj-variable-segment') -- av/iv for variable part
    use('Chun-Yang/vim-textobj-chunk') -- ac/ic for json-ish chunk
    use('whatyouhide/vim-textobj-xmlattr') -- ax/ix for xml attribute

    use({ 'tpope/vim-dispatch', config = function() require('config.dispatch') end })
    use({
      'iamcco/markdown-preview.nvim',
      run = 'cd app && yarn install',
      ft = { 'markdown' },
      cmd = 'MarkdownPreview',
      config = function() require('config.markdown-preview') end,
    })
    use('godlygeek/tabular')
    use('chrisbra/csv.vim')
    use('junegunn/vim-peekaboo')
    use({ 'NTBBloodbath/rest.nvim', config = function() require('config.rest') end })
    use('wesQ3/vim-windowswap')

    use('itchyny/lightline.vim')
    use({ 'lewis6991/gitsigns.nvim', config = function() require('config.gitsigns') end })
    use({
      'lukas-reineke/indent-blankline.nvim',
      config = function() require('config.indent-blankline') end,
    })
    use('ap/vim-css-color')
    use('aoswalt/xterm-color-table.vim')

    use({ 'Raimondi/delimitMate', config = function() require('config.delimitmate') end })
    use({
      'numToStr/Comment.nvim',
      config = function() require('Comment').setup() end,
    })
    use({
      'ntpeters/vim-better-whitespace',
      config = function() require('config.better-whitespace') end,
    })
    use('tpope/vim-repeat')
    use('tpope/vim-unimpaired')
    use({ 'kylechui/nvim-surround', config = function() require('config.surround') end })
    use('tpope/vim-abolish')
    use('tpope/vim-speeddating')
    use({ 'windwp/nvim-autopairs', config = function() require('config.autopairs') end })
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
