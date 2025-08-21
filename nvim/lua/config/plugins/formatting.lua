return {
  'mhartington/formatter.nvim',
  config = function()
    -- local function node_modules_or_global(cmd)
    --   local nm_cmd = vim.fn.join({ vim.fn.getcwd(), 'node_modules', '.bin', cmd }, '/')
    --
    --   return vim.fn.filereadable(nm_cmd) == 1 and nm_cmd or cmd
    -- end
    --
    -- local function prettier()
    --   return {
    --     exe = node_modules_or_global('prettier'),
    --     args = {
    --       '--stdin-filepath',
    --       vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
    --       '--single-quote',
    --     },
    --     stdin = true,
    --   }
    -- end
    --
    -- local function prettier_md()
    --   return {
    --     exe = node_modules_or_global('prettier'),
    --     args = {
    --       '--stdin-filepath',
    --       vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
    --       '--single-quote',
    --       '--parser',
    --       'markdown',
    --     },
    --     stdin = true,
    --   }
    -- end

    -- local function stylua()
    --   return {
    --     exe = 'stylua',
    --     args = { '-' },
    --     stdin = true,
    --   }
    -- end

    -- local function rustfmt()
    --   return {
    --     exe = 'rustfmt',
    --     args = { '--emit=stdout' },
    --     stdin = true,
    --   }
    -- end

    local function pg_format()
      return {
        exe = 'pg_format',
        args = {
          '--comma-start',
          '--comma-break',
          '--spaces',
          '2',
          '--keyword-case',
          '1',
          '--placeholder',
          '":: "',
          '--format-type',
        },
        stdin = true,
      }
    end

    local function xmllint()
      return {
        exe = 'xmllint',
        args = { '--format', '-' },
        stdin = true,
      }
    end

    require('formatter').setup({
      filetype = {
        css = { require('formatter.defaults.prettier') },
        elixir = { require('formatter.filetypes.elixir').mixformat },
        html = { require('formatter.defaults.prettier') },
        javascript = { require('formatter.defaults.prettier') },
        javascriptreact = { require('formatter.defaults.prettier') },
        json = { require('formatter.defaults.prettier') },
        lua = { require('formatter.filetypes.lua').stylua },
        markdown = { function() require('formatter.defaults.prettier')('markdown') end },
        pgsql = { pg_format },
        rust = { require('formatter.filetypes.rust').rustfmt },
        sql = { pg_format },
        xhtml = { xmllint },
        xml = { xmllint },
        yaml = { require('formatter.defaults.prettier') },
      },
    })
  end,
}
