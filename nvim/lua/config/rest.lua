require('rest-nvim').setup({
  keybinds = {
    {
      '<leader>rr',
      '<cmd>Rest run<cr>',
      'Run request under the cursor',
    },
    {
      '<leader>rl',
      '<cmd>Rest run last<cr>',
      'Re-run latest request',
    },
  },
})

-- vim.g.vrc_response_default_content_type = 'application/json'
-- vim.g.vrc_curl_opts = { ['-sS'] = '' }
