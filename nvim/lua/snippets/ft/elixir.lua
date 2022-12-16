-- luacheck: new globals s sn t f i c d r l rep p m n dl fmt fmta conds types events parse ai

local function filepath() return vim.fn.expand('%') end

return {
  s(
    'def',
    fmt(
      [[
      def {}({}) do
        {}
      end
      ]],
      { i(1, 'function'), i(2), i(0) }
    )
  ),

  s(
    'defp',
    fmt(
      [[
      defp {}({}) do
      	{}
      end
      ]],
      { i(1, 'function'), i(2), i(0) }
    )
  ),

  s(
    'defmo',
    fmt(
      [[
      defmodule {} do
      	{}
      end
      ]],
      { i(1, 'Module'), i(0) }
    )
  ),

  s(
    'defmop',
    fmt(
      [[
      defmodulep {} do
      	{}
      end
      ]],
      { i(1, 'Module'), i(0) }
    )
  ),

  s(
    'ins',
    c(1, {
      fmt('IO.inspect({}, label: "{}")', { i(1), dl(2, l._1, 1) }),
      fmt('|> IO.inspect(label: "{}")', { i(1) }),
      fmt('IO.inspect(<>, label: "<>:#{__ENV__.line}")', { i(1), f(filepath, {}) }, { delimiters = '<>' }),
      fmt('|> IO.inspect(label: "[]:#{__ENV__.line}")', { f(filepath, {}) }, { delimiters = '[]' }),
    })
  ),

  s('k', fmt('{}: {}', { i(1), dl(2, l._1, 1) })),

  s(
    'doc',
    fmt(
      [[
      @doc """
      {}
      """
      ]],
      i(0)
    )
  ),

  s('docf', t('@doc false')),

  s(
    'mdoc',
    fmt(
      [[
      @moduledoc """
      {}
      """
      ]],
      i(0)
    )
  ),

  s('mdocf', fmt('@moduledoc false\n', {})),

  s(
    'defi',
    fmt(
      [[
      defimpl {}, for: {} do
      	{}
      end
      ]],
      { i(1, 'Protocol'), i(2, 'Any'), i(0) }
    )
  ),
}
