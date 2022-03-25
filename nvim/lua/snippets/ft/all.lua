-- luacheck: new globals s sn t f i c d r l rep p m n dl fmt fmta conds types events parse ai

local function comment_prefix()
  return vim.bo.commentstring:format('') --:gsub("%S$", "%0 ")
end

local function username()
  return vim.g.username or vim.loop.os_getenv('USER')
end

local function datefmt(fmt)
  return function()
    return vim.fn['strftime'](fmt)
  end
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
}
