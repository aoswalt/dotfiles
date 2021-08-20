local null_ls = require("null-ls")
local api = vim.api

local comment_line = {
  method = null_ls.methods.CODE_ACTION,
  filetypes = { "*" },
  generator = {
    fn = function(params)
      -- sources have access to a params object
      -- containing info about the current file and editor state
      local bufnr = params.bufnr
      local line = params.content[params.row]

      -- all nvim api functions are safe to call
      local commentstring = api.nvim_buf_get_option(bufnr, "commentstring")

      -- null-ls combines and stores returned actions in its state
      -- and will call action() on execute
      return {
        {
          title = "Comment line",
          action = function()
            api.nvim_buf_set_lines(bufnr, params.row - 1, params.row, false, {
              string.format(commentstring, line),
            })
          end,
        },
      }
    end,
  },
}

null_ls.register(comment_line)
