-- luacheck: new_globals s sn t f i c d r l rep p m n dl fmt fmta conds types events parse ai

return {
  parse({ trig = 'link', dscr = 'link' }, [[[${1:Text}](${2:./link/location})]]),

  parse({ trig = 'linkt', dscr = 'link with hover text' }, [[[${1:Text}](${2:./link/location} "${3:Hover Text}")]]),

  parse({ trig = 'img', dscr = 'image' }, [[![${2:Alt Text}](${1:./path/to/img.png} "${3:Title}")]]),

  parse(
    { trig = 'imgl', dscr = 'image link' },
    [[[![${2:Alt Text}](${1:./path/to/img.png} "${3:Title}")](${4:./link/location})]]
  ),

  s(
    { trig = 'p(%d+)', regTrig = true, name = 'page - single', dscr = 'Single page number' },
    { t('(p. '), f(function(_args, snip)
      return snip.captures[1]
    end), t(')') }
  ),

  -- NOTE: can't get dynamic insert to work as expected
  -- s(
  --   { trig = 'pp(%d*%-?%d*)', regTrig = true, name = 'page - multiple', dscr = 'Multiple page numbers' },
  --   { t('(pp. '), dl(1, function(_args, snip)
  --     return snip.captures[1]
  --   end), t(')') }
  -- }),
  s(
    { trig = 'pp(%d*%-?%d*)', regTrig = true, name = 'page - multiple', dscr = 'Multiple page numbers' },
    { t('(pp. '), f(function(_args, snip)
      return snip.captures[1]
    end), i(1), t(')') }
  ),

  s({ trig = '-[', dscr = 'checkbox list' }, t('- [ ] ')),
}
