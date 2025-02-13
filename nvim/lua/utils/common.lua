local M = {}

function M.run_async(func)
   coroutine.resume(coroutine.create(function()
      local status, err = pcall(func)
      if not status then
         vim.notify(('[async] unhandled error: %s'):format(tostring(err)), vim.log.levels.WARN)
      end
   end))
end

return M
