local function generic_issue(message)
  return {
    message = message,
    lnum = 0,
    end_lnum = 1,
    col = 0,
    severity = vim.diagnostic.severity.ERROR,
    source = 'credo',
  }
end

require('lint').linters.mix_format = {
  cmd = 'mix',
  stdin = true,
  args = { 'format', '--check-formatted', '-' },
  ignore_exitcode = true,
  stream = 'stderr',
  parser = function(output)
    issues = {}

    if output and output ~= '' then
      table.insert(issues, {
        message = 'File is not formatted',
        lnum = 0,
        end_lnum = 1,
        col = 0,
        severity = vim.diagnostic.severity.WARN,
        source = 'mix_format',
      })
    end

    return issues
  end,
}

require('lint').linters.credo = {
  cmd = 'mix',
  stdin = true,
  args = { 'credo', 'suggest', '--format', 'json', '--read-from-stdin' },
  append_fname = true,
  stream = 'stdout',
  ignore_exitcode = true, -- exits with severity code
  parser = function(output)
    local issues = {}

    -- if no output to parse, stop
    if not output then
      return issues
    end

    local json_index, _ = output:find('{')

    -- if no json included, something went wrong and nothing to parse
    if not json_index then
      table.insert(issues, generic_issue(output))

      return issues
    end

    local maybe_json_string = output:sub(json_index)

    local ok, decoded = pcall(vim.json.decode, maybe_json_string)

    -- decoding broke, so give up and return the original output
    if not ok then
      table.insert(issues, generic_issue(output))

      return issues
    end

    for _, issue in ipairs(decoded.issues or {}) do
      local err = {
        message = issue.message,
        lnum = issue.line_no - 1,
        col = 0,
        source = 'credo',
      }

      -- using the dynamic priority ranges from credo source
      if issue.priority >= 10 then
        err.severity = vim.diagnostic.severity.ERROR
      elseif issue.priority >= 0 then
        err.severity = vim.diagnostic.severity.WARN
      elseif issue.priority >= -10 then
        err.severity = vim.diagnostic.severity.INFO
      else
        err.severity = vim.diagnostic.severity.HINT
      end

      if issue.column and issue.column ~= vim.NIL then
        err.col = issue.column - 1
      end

      if issue.column_end and issue.column_end ~= vim.NIL then
        err.end_col = issue.column_end - 1
      end

      table.insert(issues, err)
    end

    return issues
  end,
}

require('lint').linters_by_ft = {
  javascript = { 'eslint' },
  elixir = { 'mix_format' },
  sh = { 'shellcheck' },
}

local function file_exists(file) return vim.fn.filereadable(file) == 1 end

local M = {}

vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost' }, {
  buffer = 0,
  callback = function() require('lint').try_lint() end,
  desc = 'lint'
})

return M
