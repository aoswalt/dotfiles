-- luacheck: new globals s sn t f i c d r l rep p m n dl fmt fmta conds types events parse ai

return {
  s(
    {
      trig = 'mod',
      name = 'module',
    },
    fmt(
      [[
      local M = {}

      <>

      return M
      ]],
      { i(0) },
      { delimiters = '<>' }
    )
  ),
}
