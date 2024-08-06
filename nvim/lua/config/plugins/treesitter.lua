return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'bash',
        'bibtex',
        'c',
        'c_sharp',
        'clojure',
        'cmake',
        'comment',
        'commonlisp',
        'cooklang',
        'cpp',
        'css',
        'csv',
        'diff',
        'dockerfile',
        'dot',
        'eex',
        'elixir',
        'elm',
        'erlang',
        'fish',
        'fortran',
        'gdscript',
        'gdshader',
        'git_config',
        'git_rebase',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'gleam',
        'glsl',
        'go',
        'godot_resource',
        'gomod',
        'gowork',
        'graphql',
        'haskell',
        'heex',
        'html',
        'http',
        'java',
        'javascript',
        'jsdoc',
        'json',
        'kotlin',
        'latex',
        'llvm',
        'lua',
        'luap',
        'make',
        'markdown', -- experimental
        'markdown_inline', -- experimental
        'norg',
        'ocaml',
        'ocaml_interface',
        'ocamllex',
        'perl',
        'php',
        'python',
        'query',
        'regex',
        'ruby',
        'rust',
        'scala',
        'scss',
        'sql',
        'svelte',
        'teal', -- typed lua
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'vue',
        'wgsl',
        'wgsl_bevy',
        'yaml',
        'zig',
      },
      highlight = {
        enable = true,
      },
      playground = {
        enable = true,
      },
    })
  end,
}
