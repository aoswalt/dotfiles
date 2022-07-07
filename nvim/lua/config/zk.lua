local zk = require('zk')
local commands = require('zk.commands')

commands.add('ZkQuick', function(options)
  options = options or {}
  options = vim.tbl_extend(
    'force',
    options,
    { dir = vim.env.ZK_NOTEBOOK_DIR .. '/../quick', group = 'quick' }
  )
  zk.new(options)
end)

-- is there a way to override ZkNew?
vim.cmd(
  [[command! -nargs=+ ZkN lua require('zk').new({ dir = vim.env.ZK_NOTEBOOK_DIR, title = <q-args> })]]
)
