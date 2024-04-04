local wez = require('wezterm')

local function smart_nav(nvim_dir, wez_dir)
  return function()
    if vim.fn.winnr() == vim.fn.winnr(nvim_dir) then
      -- wez.action({ EmitEvent = 'do-nav-' .. string.lower(wez_dir) })
      wez.switch_pane.direction(wez_dir)
    else
      vim.cmd.wincmd(nvim_dir)
    end
  end
end

vim.keymap.set({ 'n', 'i' }, '<m-h>', smart_nav('h', 'Left'), { silent = true })
vim.keymap.set({ 'n', 'i' }, '<m-j>', smart_nav('j', 'Down'), { silent = true })
vim.keymap.set({ 'n', 'i' }, '<m-k>', smart_nav('k', 'Up'), { silent = true })
vim.keymap.set({ 'n', 'i' }, '<m-l>', smart_nav('l', 'Right'), { silent = true })
