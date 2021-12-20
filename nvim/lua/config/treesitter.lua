require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  ignore_install = { 'elixir' },
  highlight = {
    enable = true,
  },
  playground = {
    enable = true,
  },
}
