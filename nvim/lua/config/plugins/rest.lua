return {
  -- {
  --   'rest-nvim/rest.nvim',
  --   ft = 'http',
  --   main = 'rest-nvim',
  --   config = function()
  --     require('rest-nvim').setup({
  --       keybinds = {
  --         {
  --           '<leader>rr',
  --           '<cmd>Rest run<cr>',
  --           'Run request under the cursor',
  --         },
  --         {
  --           '<leader>rl',
  --           '<cmd>Rest run last<cr>',
  --           'Re-run latest request',
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
    }
  }
}
