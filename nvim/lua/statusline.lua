local M = {}

function M.default()
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

return M
