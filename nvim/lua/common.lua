local M = {}

function M.run_async(func)
   coroutine.resume(coroutine.create(function()
      local status, err = pcall(func)
      if not status then
         vim.notify(('[async] unhandled error: %s'):format(tostring(err)), vim.log.levels.WARN)
      end
   end))
end

local function default_statusline()
   local statusline = '['
   statusline = statusline .. ''
   statusline = statusline .. ' '
   statusline = statusline .. '%f'
   statusline = statusline .. ']'
   statusline = statusline .. ' '
   statusline = statusline .. '%m'
   statusline = statusline .. '%='
   statusline = statusline .. '['
   statusline = statusline .. '%l'
   statusline = statusline .. ':'
   statusline = statusline .. '%c'
   statusline = statusline .. ']'
   return statusline
end

function M.set_default_statusline()
   vim.opt.statusline = default_statusline()
end

function M.count_diagnostic()
   M.run_async(function()
      assert(coroutine.running())
      local diagnostics = vim.diagnostic.count(0, { severity = { min = vim.diagnostic.severity.WARN } })
      local errors = diagnostics[vim.diagnostic.severity.ERROR]
      local warnings = diagnostics[vim.diagnostic.severity.WARN]

      local statusline = default_statusline()
      if errors then
         statusline = statusline .. ' E:' .. errors
      end
      if warnings then
         statusline = statusline .. ' W:' .. warnings
      end

      vim.opt.statusline = statusline
      coroutine.yield()
   end)
end

return M
