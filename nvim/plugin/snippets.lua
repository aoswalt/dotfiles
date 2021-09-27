local ls = require'luasnip'
local s = ls.s
local sn = ls.sn
local t = ls.t
local i = ls.i
local f = ls.f
local c = ls.c
local d = ls.d

local U = require'util'

U.keymap('i', '<c-j>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-j>'", { expr = true, noremap = false, silent = true })
U.keymap('i', '<c-k>', "<cmd>lua require'luasnip'.jump(-1)<cr>", { silent = true })

U.keymap('s', '<c-j>', "<cmd>lua require'luasnip'.jump(1)<cr>", { silent = true })
U.keymap('s', '<c-k>', "<cmd>lua require'luasnip'.jump(-1)<cr>", { silent = true })

U.keymap('i', '<c-e>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-e>'", { expr = true, noremap = false, silent = true })
U.keymap('s', '<c-e>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<c-e>'", { expr = true, noremap = false, silent = true })

local function comment_prefix()
  return vim.bo.commentstring:format("") --:gsub("%S$", "%0 ")
end

local function username()
  return vim.g.username or vim.loop.os_getenv("USER")
end

local function datefmt(fmt) return vim.fn['strftime'](fmt) end

local js_snippets = {
  ls.parser.parse_snippet('im', [[import ${1} from '${2:$1}'$0]]), -- import default
  ls.parser.parse_snippet('imm', [[import { ${1} \} from '$2'$0]]), -- named import
  ls.parser.parse_snippet("c=>", [[const ${1:fun} = ${2:()} => $0]]),
  ls.parser.parse_snippet('cl', [[console.log('$1', $1)$0]]),
  ls.parser.parse_snippet("cl?", [[console.log('$1', ${2:$1}) ?? $0]]),
  ls.parser.parse_snippet('peek', [[.then(d => console.log(d) ?? d)]]),
  ls.parser.parse_snippet('ex', 'export $0'),
  ls.parser.parse_snippet('exc', [[export const ${1:name} = $0]]),
  ls.parser.parse_snippet('exf', 'export function ${1:func}($2) {\n  $0\n\\}'),
  ls.parser.parse_snippet('exd', 'export default $0'),
  ls.parser.parse_snippet('exdf', 'export default function ${1:func}($2) {\n  $0\n\\}'),
};

local react_snippets = {
  ls.parser.parse_snippet('ir', [[import React from 'react']]);
}

ls.snippets = {
  all = {
    s('todo', { f(comment_prefix, {}), t'TODO(', f(username, {}), t'): ', }),
    s('note', { f(comment_prefix, {}), t'NOTE(', f(username, {}), t'): ', }),
    s('date', f(datefmt('%Y-%m-%d'), {})),
    s('ddate', f(datefmt("%b %d, %Y"), {})), -- Month DD, YYYY
    s('diso', f(datefmt("%F %H:%M:%S%z"), {})),
    s('time', f(datefmt("%H:%M"), {})),
    s('datetime', f(datefmt("%Y-%m-%d %H:%M"), {})), -- YYYY-MM-DD hh:mm
    s('lorem', t{
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod',
        'tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At',
        'vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,',
        'no sea takimata sanctus est Lorem ipsum dolor sit amet.'
      }), -- 50 words
  },

  elixir = {
    s('def', {
        t'def ',
        i(1, 'function'),
        t'(',
        i(2),
        t{
          ') do',
          '\t'
        },
        i(0),
        t{'','end'},
      }),
    ls.parser.parse_snippet('defp', [[
defp ${1:function}($2) do
  $0
end]]),
    ls.parser.parse_snippet('defmo', [[
defmodule ${1:Module} do
  $0
end]]),
    ls.parser.parse_snippet('defmop', [[
defmodulep ${1:Module} do
  $0
end]]),
    ls.parser.parse_snippet('ins', [[IO.inspect($1, label: "${2:$1}")]]),
    ls.parser.parse_snippet('doc', '@doc """\n$0\n"""'),
    s('docf', t'@doc false'),
    s('mdoc', { t{'@moduledoc """', ''}, i(0), t{'', '"""'} }),
    s('mdocf', t{'@moduledoc false', ''}),
    ls.parser.parse_snippet('defi', [[
defimpl ${1:Protocol}, for: ${2:Any} do
  $0
end]]),
  },

  javascript = js_snippets;
  javascriptreact = vim.tbl_extend('force', js_snippets, react_snippets);
  typescript = js_snippets;
  typescriptreact = vim.tbl_extend('force', js_snippets, react_snippets);

  markdown = {
    ls.parser.parse_snippet('link', [[[${1:Text}](${2:./link/location})$0]]),
    ls.parser.parse_snippet('linkt', [[[${1:Text}](${2:./link/location} "${3:Hover Text}")$0]]); -- link with title
    ls.parser.parse_snippet('img', [[![${2:Alt Text}](${1:./path/to/img.png} "${3:Title}")$0]]);
    ls.parser.parse_snippet('imgl', [[[![${2:Alt Text}](${1:./path/to/img.png} "${3:Title}")](${4:./link/location})$0]]); -- image link
    s({ trig = 'p(%d+)', name = 'page', regTrig = true },
        f(function(args, snip) return '(p. ' .. snip.captures[1] .. ')' end, {})
    ),
    ls.parser.parse_snippet('pp', [[(pp. $1)$0]]); -- multiple page number
  },

  sql = {
    ls.parser.parse_snippet('sel', [[select ${2:*} from ${1} $0]]), -- select (columns:*) from table
    ls.parser.parse_snippet('selfun', [[select pg_get_functiondef('${0:aspire.function_name}' :: regproc)]]), -- select function definition
    ls.parser.parse_snippet('selmats', [[select oid::regclass::text from pg_class where relkind = 'm']]), -- list materialized views
    ls.parser.parse_snippet('running', [[
select
    psa.pid
  , now() - psa.query_start as running_time
  , psa.client_addr
  , psa.client_port
  , psa.application_name
  , psa.state
  , psa.query
from pg_stat_activity psa
where psa.state <> 'idle'::text and psa.query !~ 'running_queries'::text
order by psa.query_start]]), -- show running queries
    ls.parser.parse_snippet('selview', [[
select pg_get_viewdef(oid)
from pg_class
where relname = '${0:view_name}']]), -- get view definition
    ls.parser.parse_snippet('selchecks', [[
select
    nsp.nspname || '.' || rel.relname "table"
  , con.conname as constraint_name
  , con.consrc as definition
from pg_catalog.pg_constraint con
join pg_catalog.pg_class rel
  on rel.oid = con.conrelid
join pg_catalog.pg_namespace nsp
  on nsp.oid = connamespace
where con.contype = 'c' -- check constraint
order by nsp.nspname, rel.relname]]), -- list all check constraints
    ls.parser.parse_snippet('seluidx', [[
select
    s.schemaname
  , s.relname as tablename
  , s.indexrelname as indexname
  , pg_relation_size(s.indexrelid) as index_size
from pg_catalog.pg_stat_user_indexes s
join pg_catalog.pg_index i
  on s.indexrelid = i.indexrelid
where s.idx_scan = 0      -- has never been scanned
  and 0 <> all(i.indkey)  -- no index column is an expression
  and not i.indisunique   -- is not a unique index
  and not exists          -- does not enforce a constraint
      (select 1 from pg_catalog.pg_constraint c
        where c.conindid = s.indexrelid)
order by pg_relation_size(s.indexrelid) desc]]), -- list all unused indices
-- https://www.cybertec-postgresql.com/en/get-rid-of-your-unused-indexes/
    ls.parser.parse_snippet('seldeps', [[
select dependent_ns.nspname as dependent_schema
  , dependent_view.relname as dependent_view
  , source_ns.nspname as source_schema
  , source_table.relname as source_table
  , pg_attribute.attname as column_name
from pg_depend
  join pg_rewrite on pg_depend.objid = pg_rewrite.oid
  join pg_class as dependent_view on pg_rewrite.ev_class = dependent_view.oid
  join pg_class as source_table on pg_depend.refobjid = source_table.oid
  join pg_attribute on pg_depend.refobjid = pg_attribute.attrelid
    and pg_depend.refobjsubid = pg_attribute.attnum
  join pg_namespace dependent_ns on dependent_ns.oid = dependent_view.relnamespace
  join pg_namespace source_ns on source_ns.oid = source_table.relnamespace
where source_ns.nspname = '${1:schema}'
  and source_table.relname = '${2:table}'
  and pg_attribute.attnum > 0
  and pg_attribute.attname = '${3:my_column}'
order by 1, 2]]), -- find dependencies
    ls.parser.parse_snippet('selusage', [[
select *
from information_schema.view_column_usage
where table_schema = '${1:schema}'
  and table_name = '${2:table}'
  and column_name = '${3:column}']]), -- find view usages
    ls.parser.parse_snippet('selvdeps', [[
with recursive views as (
  -- get the directly depending views
  select
      v.oid::regclass as view
    , 1 as level
  from pg_depend as d
  join pg_rewrite as r
    on r.oid = d.objid
  join pg_class as v
    on v.oid = r.ev_class
  where v.relkind = 'v'
    and d.classid = 'pg_rewrite'::regclass
    and d.refclassid = 'pg_class'::regclass
    and d.deptype = 'n'
    and d.refobjid = '${0:table}'::regclass
  union all
  -- add the views that depend on these
  select
      v.oid::regclass
    , views.level + 1
  from views
  join pg_depend as d
    on d.refobjid = views.view
  join pg_rewrite as r
    on r.oid = d.objid
  join pg_class as v
    on v.oid = r.ev_class
  where v.relkind = 'v'
    and d.classid = 'pg_rewrite'::regclass
    and d.refclassid = 'pg_class'::regclass
    and d.deptype = 'n'
    and v.oid <> views.view -- avoid loop
)
select view
  -- select format('create view %s as%s', view, pg_get_viewdef(view))
from views
group by view
order by max(level)]]), -- list dependent views
    ls.parser.parse_snippet('sellargest', [[
select schemaname as table_schema,
  relname as table_name,
  pg_size_pretty(pg_total_relation_size(relid)) as total_size,
  pg_size_pretty(pg_relation_size(relid)) as data_size,
  pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) as external_size
from pg_catalog.pg_statio_user_tables
order by pg_total_relation_size(relid) desc,
         pg_relation_size(relid) desc
limit 10]]); -- list 10 largest tables
  },

}
