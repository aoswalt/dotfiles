require'indent_guides'.setup{
  indent_guide_size = 2;
}

-- setup only sets giufg and guibg
vim.api.nvim_command('hi IndentGuidesOdd ctermbg=233')
vim.api.nvim_command('hi IndentGuidesEven ctermbg=234')
