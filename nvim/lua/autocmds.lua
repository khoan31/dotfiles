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
      vim.cmd('cwindow')
   end
})
