return {
  'folke/snacks.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    -- indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    -- scroll = { enabled = true },
    -- statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        -- wo = { wrap = true } -- Wrap notifications
      },
    },
  },
  config = function()
    vim.keymap.set('n', '<leader>sf', Snacks.picker.smart, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sF', Snacks.picker.files, { desc = '[S]earch project [F]iles' })

    vim.keymap.set(
      'n',
      '<leader>/',
      function() Snacks.picker.grep_word({ search = '.*' .. vim.fn.input('Rg> ') .. '.*', regex = true }) end
    )
    vim.keymap.set('n', '<leader>?', Snacks.picker.grep)
    vim.keymap.set('n', '<leader>s/', Snacks.picker.grep, { desc = '[S]earch [?] in Open Files' })
    vim.keymap.set('n', '<leader>*', Snacks.picker.grep_word, { desc = 'super search for word under cursor' })

    vim.keymap.set('n', '<leader>sb', Snacks.picker.buffers, { desc = '[S]earch [B]uffers' })
    vim.keymap.set('n', '<leader>sB', Snacks.picker.lines, { desc = '[S]earch current [B]uffers' })

    vim.keymap.set('n', '<f1>', Snacks.picker.help, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>K', Snacks.picker.help, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sh', Snacks.picker.help, { desc = '[S]earch [H]elp' })

    vim.keymap.set('n', 'z=', Snacks.picker.spelling, { desc = 'Spell suggest' })
    vim.keymap.set('n', '<leader><leader>', Snacks.picker.commands, { desc = 'Search Commands' })

    vim.keymap.set('n', '<leader>ss', Snacks.picker.pickers, { desc = '[S]earch [S]elect pickers' })

    vim.keymap.set('n', '<leader>sk', Snacks.picker.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sw', Snacks.picker.grep_word, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', Snacks.picker.grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', Snacks.picker.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', Snacks.picker.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>s.', Snacks.picker.recent, { desc = '[S]earch Recent Files ("." for repeat)' })

    vim.keymap.set('n', '<leader>s:', Snacks.picker.command_history, { desc = '[S]earch command history (":" for command)' })
    vim.keymap.set('n', '<leader>s;', Snacks.picker.command_history, { desc = '[S]earch command history (";" for command alias)' })
  end,
}
