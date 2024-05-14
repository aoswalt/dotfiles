return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  opts = {},
  config = function()
    require('ibl').setup({
      exclude = {
        buftypes = { 'terminal' },
      },
    })
  end,
}
