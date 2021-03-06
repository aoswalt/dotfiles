local M = require'snippets'
local orig_advance = M.advance_snippet
local advance = function(offset)
  offset = offset or 1
  orig_advance(-offset)
end
M.advance_snippet = advance

-- " only applies if not using floaty; floaty is currently hardcoded, so overriding manually
vim.api.nvim_set_keymap('i', '<c-j>', [[<cmd>lua return require'snippets'.expand_or_advance(1)<CR>]], { noremap = true })
vim.api.nvim_set_keymap('i', '<c-k>', [[<cmd>lua return require'snippets'.advance_snippet(-1)<CR>]], { noremap = true })


-- could use text markers similar to ultisnips instead of popup
-- require'snippets'.set_ux(require'snippets.inserters.text_markers')

local js_snippets = {
  im = [[import ${1} from '${2:$1}'$0]]; -- import default
  imm = [[import { ${1} } from '$2'$0]]; -- named import
  ["c=>"] = [[const ${1:fun} = ${2:()} => $0]];
  cl = [[console.log('$1', $1)$0]];
  ["cl?"] = [[console.log('$1', ${2:$1}) ?? $0]];
  peek = [[.then(d => console.log(d) ?? d)]];
  ex = 'export $0';
  exc = [[export const ${1:name} = $0]];
  exf = 'export function ${1:func}($2) {\n  $0\n}';
  exd = 'export default $0';
  exdf = 'export default function ${1:func}($2) {\n  $0\n}';
};

local react_snippets = {
  ir = [[import React from 'react']];
}

local U = require'snippets.utils'
require'snippets'.snippets = {
  _global = {
    date = "${=os.date('%Y-%m-%d')}";
    ddate = [[${=vim.fn['strftime']("%b %d, %Y")}]]; -- Month DD, YYYY
    diso = [[${=vim.fn['strftime']("%F %H:%M:%S%z")}]];
    time = [[${=vim.fn['strftime']("%H:%M")}]];
    datetime = [[${=vim.fn['strftime']("%Y-%m-%d %H:%M")}]]; -- YYYY-MM-DD hh:mm
    todo = U.force_comment[[TODO(${=vim.loop.os_getenv("USER")}): ]];
    note = U.force_comment[[NOTE(${=vim.loop.os_get_passwd().username}): ]];
    lorem = [[
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren,
no sea takimata sanctus est Lorem ipsum dolor sit amet.]] -- 50 words
  };

  elixir = {
    def = U.match_indentation [[
def ${1:function}($2) do
  $0
end]];
    defp = U.match_indentation [[
defp ${1:function}($2) do
  $0
end]];
    defmo = U.match_indentation [[
defmodule ${1:Module} do
  $0
end]];
    defmop = U.match_indentation [[
defmodulep ${1:Module} do
  $0
end]];
    ins = [[IO.inspect($1, label: "${2:$1}")]];
    doc = U.match_indentation '@doc """\n$0\n"""';
    docf = '@doc false';
    mdoc = U.match_indentation '@moduledoc """\n$0\n"""\n';
    mdocf = '@moduledoc false\n';
    defi = U.match_indentation [[
defimpl ${1:Protocol}, for: ${2:Any} do
  $0
end]];
  };

  javascript = js_snippets;
  javascriptreact = vim.tbl_extend('force', js_snippets, react_snippets);
  typescript = js_snippets;
  typescriptreact = vim.tbl_extend('force', js_snippets, react_snippets);

  markdown = {
    link = [[[${1:Text}](${2:./link/location})$0]];
    linkt = [[[${1:Text}](${2:./link/location} "${3:Hover Text}")$0]]; -- link with title
    img = [[![${2:Alt Text}](${1:./path/to/img.png} "${3:Title}")$0]];
    imgl = [[[![${2:Alt Text}](${1:./path/to/img.png} "${3:Title}")](${4:./link/location})$0]]; -- image link
    p = [[(p. $1)$0]]; -- page number
    pp = [[(pp. $1)$0]]; -- multiple page number
  };

  sql = {
    sel = [[select ${2:*} from ${1} $0]]; -- select (columns:*) from table
    selfun = [[select pg_get_functiondef('${0:aspire.function_name}' :: regproc)]]; -- select function definition
    selmats = [[select oid::regclass::text from pg_class where relkind = 'm']]; -- list materialized views
    running = [[
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
order by psa.query_start]]; -- show running queries
    selview = [[
select pg_get_viewdef(oid)
from pg_class
where relname = '${0:view_name}']]; -- get view definition
    selchecks = [[
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
order by nsp.nspname, rel.relname]]; -- list all check constraints
    seluidx = [[
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
order by pg_relation_size(s.indexrelid) desc]]; -- list all unused indices
    seldeps = [[
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
order by 1, 2]]; -- find dependencies
    selusage = [[
select *
from information_schema.view_column_usage
where table_schema = '${1:schema}'
  and table_name = '${2:table}'
  and column_name = '${3:column}']]; -- find view usages
    selvdeps = [[
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
order by max(level)]]; -- list dependent views

  };
}
