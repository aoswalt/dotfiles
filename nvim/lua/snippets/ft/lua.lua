-- luacheck: new globals s sn t f i c d r l rep p m n dl fmt fmta conds types events parse ai

return {
  s(
    {
      trig = 'mod',
      name = 'module',
    },
    fmta(
      [[
      local M = {}

      <>

      return M
      ]],
      { i(0) }
    )
  ),
  s(
    {
      trig = 'fun',
      name = 'function',
    },
    c(1, {
      fmt(
        [[
        function {}({})
          {}
        end
        ]],
        { i(1, 'name'), i(2, 'args'), i(0) }
      ),
      fmt([[function({}) {} end]], { i(1, 'args'), i(0) }),
    })
  ),
}
