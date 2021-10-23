local null_ls = require('null-ls')
local api = vim.api

--NOTE(adam): from tests, but doesn't uncomment in at least some situations
-- return {
--   method = null_ls.methods.CODE_ACTION,
--   name = 'toggle_line_comment',
--   filetypes = {},
--   generator = {
--     fn = function(params)
--       local bufnr = api.nvim_get_current_buf()
--       local commentstring = api.nvim_buf_get_option(bufnr, 'commentstring')
--       local raw_commentstring = commentstring:gsub(vim.pesc('%s'), '')
--       local line = params.content[params.row]

--       if line:find(raw_commentstring, nil, true) then
--         local uncommented = line:gsub(vim.pesc(raw_commentstring), '')
--         return {
--           {
--             title = 'Uncomment line',
--             action = function()
--               api.nvim_buf_set_lines(bufnr, params.row - 1, params.row, false, {
--                 uncommented,
--               })
--             end,
--           },
--         }
--       end

--       return {
--         {
--           title = 'Comment line',
--           action = function()
--             api.nvim_buf_set_lines(bufnr, params.row - 1, params.row, false, {
--               string.format(commentstring, line),
--             })
--           end,
--         },
--       }
--     end,
--   },
-- }

--NOTE(adam): old sample code action
return {
  method = null_ls.methods.CODE_ACTION,
  filetypes = {},
  generator = {
    fn = function(params)
      -- sources have access to a params object
      -- containing info about the current file and editor state
      local bufnr = params.bufnr
      local line = params.content[params.row]

      -- all nvim api functions are safe to call
      local commentstring = api.nvim_buf_get_option(bufnr, 'commentstring')

      -- null-ls combines and stores returned actions in its state
      -- and will call action() on execute
      return {
        {
          title = 'Comment line',
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
