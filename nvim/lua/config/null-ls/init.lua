local null_ls = require('null-ls')

-- \  'xml': ['xmllint'],
-- \  'xhtml': ['xmllint'],

-- function! ale#fixers#generic#RemoveTrailingBlankLines(buffer, lines) abort
--     let l:end_index = len(a:lines) - 1

--     while l:end_index > 0 && empty(a:lines[l:end_index])
--         let l:end_index -= 1
--     endwhile

--     return a:lines[:l:end_index]
-- endfunction

-- " Remove all whitespaces at the end of lines
-- function! ale#fixers#generic#TrimWhitespace(buffer, lines) abort
--     let l:index = 0
--     let l:lines_new = range(len(a:lines))

--     for l:line in a:lines
--         let l:lines_new[l:index] = substitute(l:line, '\s\+$', '', 'g')
--         let l:index = l:index + 1
--     endfor

--     return l:lines_new
-- endfunction

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.credo.with({
      condition = function(utils)
        return utils.root_has_file('.credo.exs') or utils.root_has_file('config/.credo.exs')
      end,
    }),
    null_ls.builtins.formatting.prettier.with({ -- prettier, eslint, eslint_d, or prettierd
      --   filetypes = { "html", "css", "json", "markdown", "yaml" },
      prefer_local = 'node_modules/.bin',
    }),
    null_ls.builtins.formatting.stylua.with({
      args = { '--indent-width', '2', '--indent-type', 'Spaces', '--quote-style', 'AutoPreferSingle', '-' },
    }),
    null_ls.builtins.formatting.rustfmt,
    -- null_ls.builtins.diagnostics.shellcheck, -- ls instead?
    -- null_ls.builtins.diagnostics.luacheck, -- ls instead?
    require('config.null-ls.pgformatter'),
    require('config.null-ls.comment-line'),
  },
})
