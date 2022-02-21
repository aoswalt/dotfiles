local M = {}

-- from telescope wiki
-- use git_files if in git project; fall back to find_files if not
M.project_files = function()
  local ok = pcall(require('telescope.builtin').git_files, {})
  if not ok then
    require('telescope.builtin').find_files({ hidden = true })
  end
end

local actions = require('telescope.actions')

require('telescope').setup({
  defaults = {
    file_sorter = require('telescope.sorters').get_fzy_sorter,
    generic_sorter = require('telescope.sorters').get_fzy_sorter,
    -- prompt_prefix = '',  -- fixes using rsi in prompt but causes other issues
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      [[--glob=!.git']],
    },
    mappings = {
      i = {
        -- ["<esc>"] = actions.close,
        ['<c-f>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<a-a>'] = actions.select_all,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ['<c-d>'] = require('telescope.actions').delete_buffer,
        },
        i = {
          ['<c-d>'] = require('telescope.actions').delete_buffer,
        },
      },
    },
  },
})

U.keymap('n', '<leader>f', "<cmd>lua require('config.telescope').project_files{}<cr>")
U.keymap('n', '<leader>F', "<cmd>lua require('telescope.builtin').fd{}<cr>")

-- super search
U.keymap('n', '<leader>?', "<cmd>lua require('telescope.builtin').live_grep{}<cr>") -- can't do regex
U.keymap(
  'n',
  '<leader>/',
  "<cmd>lua require('telescope.builtin').grep_string{ search = vim.fn.input('Rg> '), use_regex = true }<cr>"
)

-- super search for word under cursor
U.keymap('n', '<leader>*', "<cmd>lua require('telescope.builtin').grep_string{}<cr>")

U.keymap('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers{}<cr>")
U.keymap('n', '<leader>B', "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find{}<cr>")

U.keymap('n', '<leader><leader>', "<cmd>lua require('telescope.builtin').commands{}<cr>")
U.keymap('n', '<leader>K', "<cmd>lua require('telescope.builtin').help_tags{}<cr>")

return M
