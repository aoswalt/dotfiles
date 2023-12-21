-- luacheck: new globals s sn t f i c d r l rep p m n dl fmt fmta conds types events parse ai

local function comment_prefix()
  return vim.bo.commentstring:format('') --:gsub("%S$", "%0 ")
end

local function username() return vim.g.username or vim.loop.os_getenv('USER') end

local function datefmt(fmt)
  return function() return vim.fn['strftime'](fmt) end
end

return {
  s('todo', { f(comment_prefix, {}), t('TODO('), f(username, {}), t('): ') }),
  s('note', { f(comment_prefix, {}), t('NOTE('), f(username, {}), t('): ') }),
  s('date', f(datefmt('%Y-%m-%d'), {})),
  s('ddate', f(datefmt('%b %d, %Y'), {})), -- Month DD, YYYY
  s('diso', f(datefmt('%F %H:%M:%S%z'), {})),
  s('time', f(datefmt('%H:%M'), {})),
  s('datetime', f(datefmt('%Y-%m-%d %H:%M'), {})), -- YYYY-MM-DD hh:mm
  s(
    { trig = 'lorem', dscr = 'Lorem Ipsum - 50 words' },
    t({
      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod',
      'tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At',
      'vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,',
      'no sea takimata sanctus est Lorem ipsum dolor sit amet.',
    })
  ),
  s(
    {
      trig = '_(%-?%d+)',
      regTrig = true,
      name = 'Number list',
      dscr = 'Create a list of numbers in various structures',
    },
    d(1, function(_args, snip)
      local n = tonumber(snip.captures[1])

      local nums = {}

      if n < 1 then
        for i = -1, n, -1 do
          table.insert(nums, tostring(i))
        end
      else
        for i = 1, n do
          table.insert(nums, tostring(i))
        end
      end

      return sn(nil, {
        c(1, {
          t(table.concat(nums, ', ')),
          t(nums),
          t(table.concat(nums, ' ')),
        }),
      })
    end, {})
  ),
}
