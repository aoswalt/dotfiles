local actions = require'telescope.actions'

require'telescope'.setup{
  defaults = {
    file_sorter = require'telescope.sorters'.get_fzy_sorter,
    generic_sorter = require'telescope.sorters'.get_fzy_sorter,
    -- prompt_prefix = '',  -- fixes using rsi in prompt but causes other issues
    mappings = {
      i = {
        -- ["<esc>"] = actions.close,
        ["<c-f>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<a-a>"] = actions.select_all,
      },
    },
  },
}

U.keymap('n', '<leader>f', "<cmd>lua require'telescope.builtin'.fd{file_ignore_patterns = {'^external/'}}<cr>")
U.keymap('n', '<leader>F', "<cmd>lua require'telescope.builtin'.git_files{}<cr>")

-- super search
U.keymap('n', '<leader>?', "<cmd>lua require'telescope.builtin'.live_grep{}<cr>") -- can't do regex
U.keymap('n', '<leader>/', "<cmd>lua require'telescope.builtin'.grep_string{ search = vim.fn.input('Rg> '), use_regex = true }<cr>")

-- super search for word under cursor
U.keymap('n', '<leader>*', "<cmd>lua require'telescope.builtin'.grep_string{}<cr>")

U.keymap('n', '<leader>b', "<cmd>lua require'telescope.builtin'.buffers{}<cr>")
U.keymap('n', '<leader>B', "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<cr>")

U.keymap('n', '<leader><leader>', "<cmd>lua require'telescope.builtin'.commands{}<cr>")
U.keymap('n', '<leader>K', "<cmd>lua require'telescope.builtin'.help_tags{}<cr>")
