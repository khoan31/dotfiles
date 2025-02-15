local common = require('utils.common')

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
vim.api.nvim_create_autocmd('TextYankPost', {
   desc = 'Highlight when yanking (copying) text',
   group = vim.api.nvim_create_augroup('highlight-on-yank', { clear = true }),
   callback = function()
      vim.highlight.on_yank()
   end
})

-- Quick exit some filetypes
vim.api.nvim_create_autocmd('FileType', {
   pattern = { 'help', 'qf', 'diff', 'checkhealth', 'fugitive', 'fugitiveblame', 'dbout' },
   group = vim.api.nvim_create_augroup('quick-exit-file', { clear = true }),
   callback = function()
      vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', { noremap = true, silent = true })
   end
})

-- Open the quickfix window whenever a quickfix command is executed
vim.api.nvim_create_autocmd('QuickFixCmdPost', {
   pattern = '[^l]*',
   group = vim.api.nvim_create_augroup('quickfix-on-command', { clear = true }),
   callback = function()
      vim.cmd('copen')
   end
})

-- Create session directory if not exist
local session_dir = vim.fn.stdpath('data') .. '/sessions'
if vim.fn.isdirectory(session_dir) == 0 then
   vim.fn.mkdir(session_dir, 'p')
end

-- Make session automatically when save a buffer or exit vim
vim.api.nvim_create_autocmd({ 'BufWritePost', 'VimLeavePre' }, {
   pattern = '*',
   group = vim.api.nvim_create_augroup('make-session', { clear = true }),
   callback = function()
      common.run_async(function()
         assert(coroutine.running())
         local arg = vim.fn.argv()[1]

         if arg == nil or arg == vim.fn.getcwd() then
            local session_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
            vim.cmd('mksession! ' .. session_dir .. '/' .. session_name .. '.vim')
         end

         coroutine.yield()
      end)
   end
})

-- Load session automatically when start vim
vim.api.nvim_create_autocmd('VimEnter', {
   pattern = '*',
   group = vim.api.nvim_create_augroup('load-session', { clear = true }),
   callback = function()
      common.run_async(function()
         assert(coroutine.running())
         local session_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
         local session_file = session_dir .. '/' .. session_name .. '.vim'

         if vim.fn.filereadable(session_file) > 0 then
            local choice = vim.fn.confirm('Load', 'Load last session? &yes\n&no\n&clear', 2, 'Question')
            if choice == 1 then
               vim.cmd('source ' .. session_file)
            end
            if choice == 3 then
               vim.fn.delete(session_file)
            end
         end
         coroutine.yield()
      end)
   end
})

-- Update statusline diagnostic count on the fly
vim.api.nvim_create_autocmd({ 'BufEnter', 'DiagnosticChanged' }, {
   pattern = '*',
   group = vim.api.nvim_create_augroup('diagnostic-count', { clear = true }),
   callback = function()
      common.run_async(function()
         assert(coroutine.running())
         local diagnostics = vim.diagnostic.count(0, { severity = { min = vim.diagnostic.severity.WARN } })
         local errors = diagnostics[vim.diagnostic.severity.ERROR]
         local warnings = diagnostics[vim.diagnostic.severity.WARN]

         local statusline = require('statusline').default()
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
})
