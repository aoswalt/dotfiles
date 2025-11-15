return {
  {
    'tpope/vim-fugitive',
    config = function()
      vim.api.nvim_create_user_command(
        'GlogRange',
        function(opts)
          local range_arg = table.concat({ '-L', opts.line1, ',', opts.line2, ':', vim.fn.expand('%') })
          vim.cmd.Git(table.concat({ '--paginate', 'log', range_arg }, ' '))
        end,
        { range = true, desc = 'git log for range' }
      )

      vim.api.nvim_create_user_command(
        'Gamend',
        function(opts)
          vim.cmd.Git(table.concat({ 'commit', '--amend', '--no-edit', opts.args }, ' '))
        end,
        { nargs = '*', desc = 'git amend without editing commit message' }
      )

      -- git push and fetch using Dispatch - :Dispatch git push

      vim.api.nvim_create_user_command(
        'Gpush',
        function(opts)
          vim.cmd.Dispatch(
            { '-dir=' .. vim.fn.FugitiveGitDir() .. ' git push ' .. opts.args, bang = opts.bang })
        end,
        { nargs = '*', bang = true, bar = true, desc = 'git push via Dispatch' })

      vim.api.nvim_create_user_command(
        'Gfetch',
        function(opts)
          vim.cmd.Dispatch({ '-dir=' .. vim.fn.FugitiveGitDir() .. ' git fetch' .. opts.args, bang = opts.bang })
        end,
        { nargs = '*', bang = true, bar = true, desc = 'git fetch via Dispatch' })

      vim.api.nvim_create_user_command(
        'Gpushf', function(opts) vim.cmd.Gpush('--force-with-lease ' .. opts.args) end,
        { nargs = '*', desc = 'git push --force-with-lease' })

      vim.api.nvim_create_user_command(
        'Gpc',
        function(opts)
          vim.cmd.Gpush(table.concat({ '--set-upstream', 'origin', vim.fn.FugitiveHead(), opts.args }, ' '))
        end,
        { nargs = '*', desc = 'git push and set upstream (create)' }
      )

      vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>')
      vim.keymap.set('n', '<leader>ga', '<cmd>Gwrite<cr>')
      vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>')
      vim.keymap.set('n', '<leader>gc', '<cmd>Git commit -v<cr>')
      vim.keymap.set('n', '<leader>gd', '<cmd>Gdiffsplit<cr>')
      vim.keymap.set('n', '<leader>gl', '<cmd>Git --paginate log<cr>')
      vim.keymap.set('v', '<leader>gl', '<cmd>GlogRange<cr>')
      vim.keymap.set('n', '<leader>gL', '<cmd>Git --paginate log -p %<cr>')
      vim.keymap.set('v', '<leader>gL', ':GlogRange<cr>', { silent = true })
      vim.keymap.set('n', '<leader>gr', '<cmd>Git rebase -i --autosquash<cr>')
    end
  },
  {
    'junegunn/gv.vim',
    config = function() vim.keymap.set('n', '<leader>gv', '<cmd>GV<cr>') end,
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        --numhl = true,
        signs = {
          delete = {
            show_count = true,
          },
          topdelete = {
            show_count = true,
          },
        },
        count_chars = {
          [1] = '₁',
          [2] = '₂',
          [3] = '₃',
          [4] = '₄',
          [5] = '₅',
          [6] = '₆',
          [7] = '₇',
          [8] = '₈',
          [9] = '₉',
          ['+'] = '₊',
        },
        on_attach = function(bufnr)
          vim.keymap.set('n', ']c', function()
            if vim.opt.diff:get() then
              return ']c'
            else
              return "<cmd>lua require('gitsigns').next_hunk()<cr>"
            end
          end, { buffer = bufnr, expr = true })
          vim.keymap.set('n', '[c', function()
            if vim.opt.diff:get() then
              return '[c'
            else
              return "<cmd>lua require('gitsigns').prev_hunk()<cr>"
            end
          end, { buffer = bufnr, expr = true })

          vim.keymap.set('n', ']h', function() require('gitsigns').next_hunk() end, { buffer = bufnr })
          vim.keymap.set('n', '[h', function() require('gitsigns').prev_hunk() end, { buffer = bufnr })

          vim.keymap.set('n', 'ghs', function() require('gitsigns').stage_hunk() end, { buffer = bufnr })
          vim.keymap.set('n', 'ghu', function() require('gitsigns').reset_hunk() end, { buffer = bufnr })
          vim.keymap.set(
            'n',
            'ghU',
            function() require('gitsigns').undo_stage_hunk() end,
            { buffer = bufnr }
          )
          vim.keymap.set('n', 'ghr', function() require('gitsigns').reset_hunk() end, { buffer = bufnr })
          vim.keymap.set(
            'n',
            'ghR',
            function() require('gitsigns').reset_buffer() end,
            { buffer = bufnr }
          )
          vim.keymap.set(
            'n',
            'ghp',
            function() require('gitsigns').preview_hunk() end,
            { buffer = bufnr }
          )
          vim.keymap.set(
            'n',
            'ghb',
            function() require('gitsigns').blame_line(true) end,
            { buffer = bufnr }
          )

          -- Text objects
          vim.keymap.set('o', 'ic', function() require('gitsigns').select_hunk() end, { buffer = bufnr })
          vim.keymap.set('x', 'ic', function() require('gitsigns').select_hunk() end, { buffer = bufnr })
          vim.keymap.set('o', 'ih', function() require('gitsigns').select_hunk() end, { buffer = bufnr })
          vim.keymap.set('x', 'ih', function() require('gitsigns').select_hunk() end, { buffer = bufnr })

          -- Option Toggles
          vim.keymap.set(
            'n',
            '[oghs',
            function() require('gitsigns').toggle_signs() end,
            { buffer = bufnr, silent = true }
          )
          vim.keymap.set(
            'n',
            ']oghs',
            function() require('gitsigns').toggle_signs() end,
            { buffer = bufnr, silent = true }
          )
          vim.keymap.set(
            'n',
            '[oghn',
            function() require('gitsigns').toggle_numhl() end,
            { buffer = bufnr, silent = true }
          )
          vim.keymap.set(
            'n',
            ']oghn',
            function() require('gitsigns').toggle_numhl() end,
            { buffer = bufnr, silent = true }
          )
          vim.keymap.set(
            'n',
            '[oghl',
            function() require('gitsigns').toggle_linehl() end,
            { buffer = bufnr, silent = true }
          )
          vim.keymap.set(
            'n',
            ']oghl',
            function() require('gitsigns').toggle_linehl() end,
            { buffer = bufnr, silent = true }
          )
          vim.keymap.set(
            'n',
            '[oghb',
            function() require('gitsigns').toggle_current_line_blame() end,
            { buffer = bufnr, silent = true }
          )
          vim.keymap.set(
            'n',
            ']oghb',
            function() require('gitsigns').toggle_current_line_blame() end,
            { buffer = bufnr, silent = true }
          )
        end,
      })
    end,
  },
}
