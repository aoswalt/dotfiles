return {
  'tpope/vim-dadbod',
  'kristijanhusak/vim-dadbod-completion',
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod' },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_use_nvim_notify = 1
      -- vim.g.db_ui_hide_schemas = {'pg_catalog', 'pg_toast_temp.*'}
      vim.g.db_ui_execute_on_save = 0

      vim.g.db_ui_table_helpers = {
        postgresql = {
          Count = 'select count(*) from {table}',
        },
      }

      vim.api.nvim_create_autocmd({ 'FileType' }, {
        pattern = { 'dbout' },
        callback = function() vim.wo[0].foldenable = false end,
        desc = 'nofold dbout',
      })
    end,
  },
}
