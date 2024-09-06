-- luacheck: new globals s sn t f i c d r l rep p m n dl fmt fmta conds types events parse ai

return {
  s(
    { trig = 'im', dscr = 'import default' },
    fmt([[import {} from '{}']], { i(1), dl(2, l._1, 1) })
  ),

  s({ trig = 'imm', dscr = 'named import' }, fmta([[import { <> } from '<>']], { i(1), i(2) })),

  s({
    trig = 'cl',
    dscr = 'console log/warn/error',
  }, {
    t('console.'),
    c(2, {
      t('log'),
      t('warn'),
      t('error'),
    }),
    t("('"),
    rep(1),
    t("', "),
    i(1),
    t(')'),
  }),

  -- easier but does not preserve input values
  s(
    {
      trig = 'cl2',
      dscr = 'console log/warn/error',
    },
    c(1, {
      fmta("console.log('<>', <>)", { rep(1), i(1) }),
      fmta("console.warn('<>', <>)", { rep(1), i(1) }),
      fmta("console.error('<>', <>)", { rep(1), i(1) }),
    })
  ),

  parse('cl?', [[console.log('$1', ${2:$1}) ?? $0]]),

  parse('peek', [[.then(d => console.log(d) ?? d)]]),

  parse('c=>', [[const ${1:fun} = ${2:()} => $0]]),

  parse('ex', 'export $0'),

  parse('exc', [[export const ${1:name} = $0]]),

  parse('exf', 'export function ${1:func}($2): $3 {\n  $0\n\\}'),

  parse('exd', 'export default $0'),

  parse('exdf', 'export default function ${1:func}($2): $3 {\n  $0\n\\}'),
}
