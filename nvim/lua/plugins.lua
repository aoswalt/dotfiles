require('packer').startup({
  function(use)
    use('wbthomason/packer.nvim')

    use({ 'nathom/tmux.nvim', config = [[require('config.tmux')]] })

    use('justinmk/vim-dirvish')
    use('simnalamburt/vim-mundo')
    use({
      'junegunn/fzf',
      run = function()
        vim.fn['fzf#install']()
      end,
    })
    use('junegunn/fzf.vim')
    use('tpope/vim-fugitive')
    use('junegunn/gv.vim')
    use('stefandtw/quickfix-reflector.vim')
    use('wsdjeg/vim-fetch')

    use('nvim-lua/plenary.nvim')
    use({ 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } })

    use({ 'nvim-treesitter/nvim-treesitter', branch = '0.5-compat', run = ':TSUpdate' })
    use('nvim-treesitter/playground')

    use('sheerun/vim-polyglot')
    use('exu/pgsql.vim')
    use('plasticboy/vim-markdown') -- included in polyglot but without extra features
    use('habamax/vim-godot')
    use('junegunn/limelight.vim')

    use('neovim/nvim-lspconfig')
    use({ 'jose-elias-alvarez/null-ls.nvim', branch = 'main' })
    use({ 'jose-elias-alvarez/nvim-lsp-ts-utils', branch = 'main' })
    use({ 'hrsh7th/nvim-cmp', branch = 'main' })
    use({ 'hrsh7th/cmp-buffer', branch = 'main' })
    use({ 'hrsh7th/cmp-path', branch = 'main' })
    use({ 'hrsh7th/cmp-calc', branch = 'main' })
    use({ 'hrsh7th/cmp-nvim-lsp', branch = 'main' })
    use({ 'hrsh7th/cmp-nvim-lua', branch = 'main' })
    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')
    use({
      'w0rp/ale',
      cmd = 'ALEEnable',
      config = 'vim.cmd[[ALEEnable]]',
    })

    use('kana/vim-textobj-user')
    use('kana/vim-textobj-entire') -- ae/ie for entire file
    use('kana/vim-textobj-indent') -- ai/ii for indent block
    use('kana/vim-textobj-line') -- al/il for line
    use('sgur/vim-textobj-parameter') -- a,/i, for argument/parameter
    use('Julian/vim-textobj-variable-segment') -- av/iv for variable part
    use('Chun-Yang/vim-textobj-chunk') -- ac/ic for json-ish chunk
    use('whatyouhide/vim-textobj-xmlattr') -- ax/ix for xml attribute

    use('tpope/vim-dispatch')
    use({ 'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview' })
    use('godlygeek/tabular')
    use('chrisbra/csv.vim')
    use('junegunn/vim-peekaboo')
    use('diepm/vim-rest-console')
    use('wesQ3/vim-windowswap')

    use('itchyny/lightline.vim')
    use({ 'lewis6991/gitsigns.nvim', branch = 'main', config = [[require('config.gitsigns')]] })
    use({ 'lukas-reineke/indent-blankline.nvim', config = [[require('config.indent-blankline')]] })
    use('ap/vim-css-color')
    use('aoswalt/xterm-color-table.vim')
    use('vim-scripts/AnsiEsc.vim')

    use('Raimondi/delimitMate')
    use('tpope/vim-commentary')
    use('ntpeters/vim-better-whitespace')
    use('tpope/vim-repeat')
    use('tpope/vim-unimpaired')
    use('tpope/vim-surround')
    use('tpope/vim-abolish')
    use('tpope/vim-scriptease')
    use('tpope/vim-speeddating')
    use('tpope/vim-endwise')
    use('tpope/vim-rsi')
    use('tpope/vim-dadbod')

    use('wannesm/wmgraphviz.vim')

    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    display = {
      open_cmd = 'leftabove 65vnew \\[packer\\]',
    },
  },
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])
