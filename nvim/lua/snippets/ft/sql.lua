-- luacheck: new globals s sn t f i c d r l rep p m n dl fmt fmta conds types events parse ai

return {
  s(
    'sel',
    c(1, {
      fmt([[select {} from {} ]], { i(2, '*'), i(1, 'table') }),
      fmt(
        [[
        select {}
        from {}
        {}
        ]],
        { i(2, '*'), i(1, 'table'), i(0) }
      ),
      fmt(
        [[
        select
            {}
          , {}
        from {}
        {}
        ]],
        { i(2, '*'), i(3, '*'), i(1, 'table'), i(0) }
      ),
    })
  ),

  parse(
    { trig = 'selfun', dscr = "show a function's definition" },
    [[select pg_get_functiondef('${0:schema.function_name}' :: regproc)]]
  ),

  parse(
    { trig = 'selmats', dscr = 'list materialized views' },
    [[select oid::regclass::text from pg_class where relkind = 'm']]
  ),

  s(
    { trig = 'running', dscr = 'show running queries' },
    fmt(
      [[
      select
          pid
        , now() - query_start as running_time
        , client_addr
        , client_port
        , application_name
        , state
        , query
      from pg_stat_activity
      where state != 'idle'
        and pid != pg_backend_pid()
      order by query_start
      ]],
      {}
    )
  ),

  s(
    { trig = 'stop', dscr = 'stop a running query' },
    fmt('select pg_cancel_backend({})', { i(1, '__pid__') })
  ),

  s(
    { trig = 'kill', dscr = 'kill a running query - be careful, try stop/cancel first!' },
    fmt('select pg_terminate_backend({})', { i(1, '__pid__') })
  ),

  s(
    { trig = 'selview', dscr = "get a view's definition" },
    fmt(
      [[
        select pg_get_viewdef(oid)
        from pg_class
        where relname = '{}'
      ]],
      { i(1, 'view_name') }
    )
  ),

  s(
    { trig = 'selchecks', dscr = 'list check constraints' },
    fmt(
      [[
        select
            nsp.nspname || '.' || rel.relname "table"
          , con.conname as constraint_name
          , pg_get_constraintdef(con.oid) as definition
        from pg_catalog.pg_constraint con
        join pg_catalog.pg_class rel
          on rel.oid = con.conrelid
        join pg_catalog.pg_namespace nsp
          on nsp.oid = connamespace
        where con.contype = 'c' -- check constraint
        order by nsp.nspname, rel.relname
      ]],
      {}
    )
  ),

  s(
    { trig = 'seluidx', dscr = 'list unused indices' },
    fmt(
      [[
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
        order by pg_relation_size(s.indexrelid) desc
      ]],
      {}
    )
  ),
  -- https://www.cybertec-postgresql.com/en/get-rid-of-your-unused-indexes/

  s(
    { trig = 'seldeps', dscr = 'find dependencies' },
    fmt(
      [[
      select
          dependent_ns.nspname as dependent_schema
        , dependent_view.relname as dependent_view
        , source_ns.nspname as source_schema
        , source_table.relname as source_table
        , pg_attribute.attname as column_name
      from pg_depend
      join pg_rewrite
        on pg_depend.objid = pg_rewrite.oid
      join pg_class as dependent_view
        on pg_rewrite.ev_class = dependent_view.oid
      join pg_class as source_table
        on pg_depend.refobjid = source_table.oid
      join pg_attribute
        on pg_depend.refobjid = pg_attribute.attrelid
       and pg_depend.refobjsubid = pg_attribute.attnum
      join pg_namespace dependent_ns
        on dependent_ns.oid = dependent_view.relnamespace
      join pg_namespace source_ns
        on source_ns.oid = source_table.relnamespace
      where source_ns.nspname = '{schema}'
        and source_table.relname = '{table}'
        and pg_attribute.attnum > 0
        and pg_attribute.attname = '{my_column}'
      order by 1, 2
    ]],
      {
        schema = i(1, 'schema'),
        table = i(2, 'table'),
        my_column = i(3, 'my_column'),
      }
    )
  ),

  s(
    { trig = 'selusage', dscr = 'find view usages' },
    fmt(
      [[
      select *
      from information_schema.view_column_usage
      where table_schema = '{schema}'
        and table_name = '{table}'
        and column_name = '{column}'
    ]],
      {
        schema = i(1, 'schema'),
        table = i(2, 'table'),
        column = i(3, 'column'),
      }
    )
  ),

  s(
    { trig = 'selvdeps', dscr = 'find dependent views from table' },
    fmt(
      [[
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
          and d.refobjid = '{table}'::regclass
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
      order by max(level)
    ]],
      { table = i(1, 'table') }
    )
  ),

  s(
    { trig = 'sellargest', dscr = 'list largest tables' },
    fmt(
      [[
        select
            schemaname as table_schema
          , relname as table_name
          , pg_size_pretty(pg_total_relation_size(relid)) as total_size
          , pg_size_pretty(pg_relation_size(relid)) as data_size
          , pg_size_pretty(pg_total_relation_size(relid) - pg_relation_size(relid)) as external_size
        from pg_catalog.pg_statio_user_tables
        order by pg_total_relation_size(relid) desc
               , pg_relation_size(relid) desc
        limit {}
      ]],
      { i(1, '10') }
    )
  ),

  s(
    'fix_sequence',
    fmt(
      [[select setval(pg_get_serial_sequence('{}', '{}'), (select max({}) from {}))]],
      { i(1, 'schema.table'), i(2, 'id'), rep(2), rep(1) }
    )
  ),

  s('unaligned', t('\\pset format unaligned \\;')),
  s('expanded', t('\\pset expanded \\;')),
}
