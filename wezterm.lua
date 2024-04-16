local wezterm = require('wezterm')
local mux = wezterm.mux
local os = require('os')

local req_status, req_local_config = pcall(require, 'local_config')

local local_config = nil

if req_status then
  local_config = req_local_config
else
  local_config = {}
  wezterm.log_error('could not load local config -', req_local_config)
end

local config = wezterm.config_builder()

config.font_size = 18

config.colors = {
  foreground = 'white',
  background = 'black',
  ansi = {
    -- black
    '#555555',
    -- red
    '#d54e53',
    -- green
    '#b9ca4a',
    -- yellow
    '#e6c547',
    -- blue
    '#7aa6da',
    -- magenta
    '#c397d8',
    -- cyan
    '#70c0ba',
    -- white
    '#eaeaea',
  },
  brights = {
    -- black
    '#777777',
    -- red
    '#ff3334',
    -- green
    '#9ec400',
    -- yellow
    '#e7c547',
    -- blue
    '#7aa6da',
    -- magenta
    '#b77ee0',
    -- cyan
    '#54ced6',
    -- white
    '#ffffff',
  },
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.hide_tab_bar_if_only_one_tab = true
config.tab_max_width = 32

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.8,
}

config.disable_default_key_bindings = true

local mods = 'CTRL|SHIFT|ALT'
local act = wezterm.action

local tab_shortcuts = {
  F12 = { path = './.dotfiles', title = 'dotfiles' },
}

-- merge shortcuts defined in local config
if local_config.tab_shortcuts then
  for key, conf in pairs(local_config.tab_shortcuts) do
    tab_shortcuts[key] = conf
  end
end

local function open_tab(key)
  return wezterm.action_callback(function(window, pane)
    local shortcut = tab_shortcuts[key]

    if shortcut then
      local tab, pane, window =
        window:mux_window():spawn_tab({ cwd = os.getenv('HOME') .. '/' .. shortcut.path })
      tab:set_title(shortcut.title)
    else
      wezterm.log_error('No tab shortcut defined for', key)
    end
  end)
end

config.keys = {
  { key = 'p', mods = mods, action = act.ActivateCommandPalette },
  { key = 'l', mods = mods, action = act.ShowDebugOverlay },

  { key = 'c', mods = 'SUPER', action = act.CopyTo('Clipboard') },
  { key = 'v', mods = 'SUPER', action = act.PasteFrom('Clipboard') },
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo('Clipboard') },
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom('Clipboard') },
  { key = 'c', mods = mods, action = act.CopyTo('Clipboard') },
  { key = 'v', mods = mods, action = act.PasteFrom('Clipboard') },

  { key = 'Insert', mods = 'CTRL', action = act.CopyTo('PrimarySelection') },
  { key = 'Insert', mods = 'SHIFT', action = act.CopyTo('PrimarySelection') },
  { key = 'Insert', mods = mods, action = act.CopyTo('PrimarySelection') },

  { key = 'n', mods = mods, action = act.SpawnWindow },

  { key = '-', mods = 'SUPER', action = act.DecreaseFontSize },
  { key = '-', mods = mods, action = act.DecreaseFontSize },
  { key = '+', mods = 'SUPER', action = act.IncreaseFontSize },
  { key = '+', mods = mods, action = act.IncreaseFontSize },
  { key = '0', mods = 'SUPER', action = act.ResetFontSize },
  { key = '0', mods = mods, action = act.ResetFontSize },

  -- SpawnTab tries to use current directory
  { key = 't', mods = mods, action = act.SpawnCommandInNewTab({ cwd = os.getenv('HOME') }) },
  { key = 'w', mods = mods, action = act.CloseCurrentTab({ confirm = true }) },

  {
    key = 'e',
    mods = mods,
    action = act.PromptInputLine({
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:active_tab():set_title(line)
        end
      end),
    }),
  },

  { key = '\\', mods = mods, action = act.SplitHorizontal },
  { key = '_', mods = mods, action = act.SplitVertical },

  { key = '<', mods = mods, action = act.ActivateTabRelative(-1) },
  { key = '>', mods = mods, action = act.ActivateTabRelative(1) },

  { key = '{', mods = mods, action = act.MoveTabRelative(-1) },
  { key = '}', mods = mods, action = act.MoveTabRelative(1) },

  { key = 'r', mods = mods, action = act.ReloadConfiguration },

  { key = 'f', mods = mods, action = act.Search({ CaseSensitiveString = '' }) },
  { key = 'x', mods = mods, action = act.ActivateCopyMode },
  { key = 'Space', mods = mods, action = act.QuickSelect },

  { key = 'LeftArrow', mods = mods, action = act.AdjustPaneSize({ 'Left', 1 }) },
  { key = 'DownArrow', mods = mods, action = act.AdjustPaneSize({ 'Down', 1 }) },
  { key = 'UpArrow', mods = mods, action = act.AdjustPaneSize({ 'Up', 1 }) },
  { key = 'RightArrow', mods = mods, action = act.AdjustPaneSize({ 'Right', 1 }) },

  -- { key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
  -- { key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },
  -- { key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
  -- { key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },

  -- pane move(vim aware)
  { key = 'h', mods = 'ALT', action = wezterm.action({ EmitEvent = 'key-nav-left' }) },
  { key = 'j', mods = 'ALT', action = wezterm.action({ EmitEvent = 'key-nav-down' }) },
  { key = 'k', mods = 'ALT', action = wezterm.action({ EmitEvent = 'key-nav-up' }) },
  { key = 'l', mods = 'ALT', action = wezterm.action({ EmitEvent = 'key-nav-right' }) },

  { key = 'z', mods = mods, action = act.TogglePaneZoomState },

  { key = 'F1', mods = mods, action = open_tab('F1') },
  { key = 'F2', mods = mods, action = open_tab('F2') },
  { key = 'F3', mods = mods, action = open_tab('F3') },
  { key = 'F4', mods = mods, action = open_tab('F4') },
  { key = 'F5', mods = mods, action = open_tab('F5') },
  { key = 'F6', mods = mods, action = open_tab('F6') },
  { key = 'F7', mods = mods, action = open_tab('F7') },
  { key = 'F8', mods = mods, action = open_tab('F8') },
  { key = 'F9', mods = mods, action = open_tab('F9') },
  { key = 'F10', mods = mods, action = open_tab('F10') },
  { key = 'F11', mods = mods, action = open_tab('F11') },
  { key = 'F12', mods = mods, action = open_tab('F12') },
}

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

-- ideally, be smarter about titles to not show machine and combine path + program
-- wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
--   -- prefer the title that was set via `tab:set_title()`
--   -- or `wezterm cli set-tab-title`, but falls back to the
--   -- title of the active pane in that tab.
--
--   local title = tab.tab_title
--   -- if the tab title is explicitly set, take that
--   if title and #title > 0 then
--     return title
--   end
--
--   -- Otherwise, use the title from the active pane
--   -- in that tab
--   return tab.active_pane.title
-- end)

local smart_nvim_nav = function(window, pane, direction_wez, direction_nvim)
  -- if wezterm can talk to neovim, neovim would not need any custom navigation config
  -- local nvim_success, nvim_type, nvim_status = os.execute(
  --   'return $(test $(nvim --server $NVIM --clean --headless --remote-expr \'winnr() == winnr("'
  --     .. direction_nvim
  --     .. '")\') -eq 1)'
  -- )

  if pane:get_foreground_process_name():match('%nvim') then
    window:perform_action(
      wezterm.action({ SendKey = { key = direction_nvim, mods = 'ALT' } }),
      pane
    )
  else
    window:perform_action(wezterm.action({ ActivatePaneDirection = direction_wez }), pane)
  end

  -- if nvim_success and nvim_type == 'exit' and nvim_status == 1 then
  --   window:perform_action(wezterm.action({ SendString = '\x17' .. direction_nvim }), pane)
  -- else
  --   window:perform_action(wezterm.action({ ActivatePaneDirection = direction_wez }), pane)
  -- end
end

local do_nav = function(window, pane, direction_wez)
  window:perform_action(wezterm.action({ ActivatePaneDirection = direction_wez }), pane)
end

wezterm.on('key-nav-left', function(window, pane) smart_nvim_nav(window, pane, 'Left', 'h') end)
wezterm.on('key-nav-down', function(window, pane) smart_nvim_nav(window, pane, 'Down', 'j') end)
wezterm.on('key-nav-up', function(window, pane) smart_nvim_nav(window, pane, 'Up', 'k') end)
wezterm.on('key-nav-right', function(window, pane) smart_nvim_nav(window, pane, 'Right', 'l') end)

-- wezterm.on('do-nav-left', function(window, pane) do_nav(window, pane, 'Left') end)
-- wezterm.on('do-nav-down', function(window, pane) do_nav(window, pane, 'Down') end)
-- wezterm.on('do-nav-up', function(window, pane) do_nav(window, pane, 'Up') end)
-- wezterm.on('do-nav-right', function(window, pane) do_nav(window, pane, 'Right') end)

if local_config.apply_to_config then
  local_config.apply_to_config(config)
end

return config
