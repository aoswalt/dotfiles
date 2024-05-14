return {
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<F5>', '<cmd>UndotreeToggle<CR>', { silent = true })

    vim.g.undotree_SplitWidth = 70
    vim.g.undotree_DiffpanelHeight = 20
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_TreeNodeShape = '*'
    vim.g.undotree_TreeVertShape = '│'
    vim.g.undotree_TreeSplitShape = '╱'
    vim.g.undotree_TreeReturnShape = '╲'
  end,
}
