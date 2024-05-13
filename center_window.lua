-- https://github.com/FraserLee/ScratchPad/blob/main/lua/scratchpad.lua

-- check if a window is a scratchpad, win_id = 0 -> current window
local function is_scratchpad(win_id)
  local win_var = fn.getwinvar(win_id, 'is_scratchpad')
  return type(win_var) == 'boolean' and win_var
end

-- could adapt to make a simplified writing mode

local function windows()
  local tab_id = api.nvim_get_current_tabpage()
  return api.nvim_tabpage_list_wins(tab_id)
end

-- returns list of (scratchpads, non-scratchpads) on current tab
local function partition()
  local scratchpads = {}
  local non_scratchpads = {}

  for _, win_id in ipairs(windows()) do
    if is_scratchpad(win_id) then
      table.insert(scratchpads, win_id)
    else
      table.insert(non_scratchpads, win_id)
    end
  end

  return scratchpads, non_scratchpads
end

-- given a scratchpad and a non-scratchpad, set sizes so the non-scratchpad is
-- centred with reference to the box of the two. If keep_open is false, the
-- scratchpad might be closed if things are too tight.
local function set_size(non_scratchpad, scratchpad, keep_open)
  local win_info = fn.getwininfo(non_scratchpad)[1]
  local total_width = win_info.width + fn.getwininfo(scratchpad)[1].width
  local total_text = total_width - win_info.textoff

  -- if the scratchpad is too thin, possibly close it
  if total_text < vim.g.scratchpad_textwidth + 2 * vim.g.scratchpad_minwidth and not keep_open then
    M.close()
    return
  end

  local excess = total_text - vim.g.scratchpad_textwidth
  local excess_left = math.max(math.floor(excess / 2), vim.g.scratchpad_minwidth)

  api.nvim_win_set_width(scratchpad, excess_left)
  api.nvim_win_set_width(non_scratchpad, total_width - excess_left)
end
