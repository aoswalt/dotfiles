return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local trouble = require('trouble')
    local symbols = trouble.statusline({
      mode = 'lsp_document_symbols',
      groups = {},
      title = false,
      filter = { range = true },
      format = '{kind_icon}{symbol.name:Normal}',
      -- The following line is needed to fix the background color
      -- Set it to the lualine section you want to use
      hl_group = 'lualine_c_normal',
    })

    local custom_powerline = require('lualine.themes.powerline')

    custom_powerline.command = {
      a = { bg = '#c5a510', fg = '#653000', gui = 'bold' },
    }

    custom_powerline.terminal = {
      a = { bg = '#121212', fg = '#00bb22', gui = 'bold' },
    }

    require('lualine').setup({
      options = {
        theme = custom_powerline,
        -- always_show_tabline = false,
        section_separators = { left = '', right = '' },
        component_separators = { left = '│', right = '│' },
      },
      extensions = { 'oil', 'man', 'fugitive', 'lazy', 'trouble' },
      sections = {
        lualine_b = { 'filename' },
        lualine_c = { 'diagnostics' },
        lualine_x = { 'diff', 'branch' },
        lualine_y = { 'filetype' },
        lualine_z = { 'progress', 'location' },
      },
      tabline = {
        lualine_a = {
          {
            'tabs',
            mode = 2,
            -- let tab list take up 80% of the width
            max_length = vim.o.columns * 0.8,
            tabs_color = {
              active = 'lualine_b_normal',
              inactive = 'lualine_c_normal',
            },
          },
        },
        lualine_x = {
          { symbols.get, cond = symbols.has },
        },
      },
    })

    vim.api.nvim_set_hl(0, 'TabLineFill', { link = 'lualine_c_normal' })
  end,
}

-- function! ExpandedFilename()
--   let l:filename = expand('%')
--   return len(l:filename) > 0 ? l:filename : '[No Name]'
-- endfunction

-- let g:lightline = {
-- \   'component': {
-- \     'readonly': '%{&readonly?"\ue0a2":""}',
-- \   },
-- \   'component_function': {
-- \     'filename': 'ExpandedFilename',
-- \     'gitversion': 'GitVersion'
-- \   },
-- \   'active': {
-- \     'right': [
-- \        [ 'lineinfo' ],
-- \        [ 'gitversion', 'percent' ],
-- \        [ 'filetype' ],
-- \     ]
-- \   },
-- \   'inactive': {
-- \     'right': [
-- \        [ 'lineinfo' ],
-- \        [ 'gitversion', 'percent' ],
-- \     ]
-- \   },
-- \ }
--
-- function! GitVersion()
--   let l:fullname = expand('%')
--   let l:gitversion = ''
--
--   if l:fullname =~? 'fugitive://.*/\.git//0/.*'
--     let l:gitversion = 'git index'
--   elseif l:fullname =~? 'fugitive://.*/\.git//2/.*'
--     let l:gitversion = 'git target'
--   elseif l:fullname =~? 'fugitive://.*/\.git//3/.*'
--     let l:gitversion = 'git merge'
--   elseif &diff == 1
--     let l:gitversion = 'working copy'
--   endif
--
--   return l:gitversion
-- endfunction
