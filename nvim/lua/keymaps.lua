-- Clear highlights on search when pressing <Esc> in normal mode and exit terminal
vim.keymap.set('n', '<Esc>', '<Cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open [d]iagnostic float' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev [d]iagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next [d]iagnostic' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [q]uickfix list' })

-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Use CTRL+<hjkl> to switch between windows within terminal
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Use arrow keys for resize
vim.keymap.set('n', '<Up>', '<Cmd>resize +2<CR>', { desc = 'Increase window size vertically', silent = false })
vim.keymap.set('n', '<Down>', '<Cmd>resize -2<CR>', { desc = 'Decrease window size vertically', silent = false })
vim.keymap.set('n', '<Left>', '<Cmd>vertical resize -2<CR>',
   { desc = 'Decrease window size horizontally', silent = false })
vim.keymap.set('n', '<Right>', '<Cmd>vertical resize +2<CR>',
   { desc = 'Increase window size horizontally', silent = false })

-- Navigate through quickfix list
vim.keymap.set('n', ']q', '<Cmd>cnext<CR>zz', { desc = 'Next [q]uickfix item' })
vim.keymap.set('n', ']q', '<Cmd>cprev<CR>zz', { desc = 'Previous [q]uickfix item' })

-- Search current marked text
vim.keymap.set('v', '//', [[y/\V<C-r>=escape(@",'/\')<CR><CR>]], { desc = 'Search current marked text' })

-- Yank marked text/paste to/from global register
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = '[Y]ank line to global register' })
vim.keymap.set('v', '<leader>y', '"+y', { desc = '[y]ank marked text to global register' })
vim.keymap.set('n', '<leader>p', '"+p', { desc = '[p]aste text from global register' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = '[p]aste and replace marked text using global register' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = '[P]aste text from global register' })

-- Search and replace
vim.keymap.set('n', '<leader>r', ':%s/<C-r><C-w>//g<Left><Left>',
   { desc = 'Find and [r]eplace all occurrences of current <cword>' })
vim.keymap.set('v', '<leader>r', '"5y:%s/<C-r>5//g<Left><Left>',
   { desc = 'Find and [r]eplace all occurrences of current marked text' })

-- Copy, move and remove file
vim.keymap.set('n', '<leader>sc', ':!cp -r %:p<C-z> %:p:h<Left><Left><Left><Left><Left><Left>',
   { desc = '[s]hell [c]opy current file' })
vim.keymap.set('n', '<leader>sm', ':!mv %:p<C-z> %:p:h<Left><Left><Left><Left><Left><Left>',
   { desc = '[s]hell [m]ove current file' })
vim.keymap.set('n', '<leader>sr', ':!rm -rf %:p<C-z>', { desc = '[s]hell [r]emove current file' })

-- Default fuzzy find
vim.keymap.set('n', '<leader>f', ':find **/*', { desc = '[f]ind files' })
vim.keymap.set('v', '<leader>f', '"0y:find **/*<C-r>0<C-z>', { desc = '[f]ind files match marked text' })
vim.keymap.set('n', '<leader>F', ':find **/*<C-r><C-w><C-z>', { desc = '[F]ind files match current <cword>' })
vim.keymap.set('n', '<leader>e', ':e %:p:h<C-z>', { desc = 'Browse files, [e]dit selected one' })
vim.keymap.set('n', '<leader>b', ':b <C-z>', { desc = 'Browse [b]uffers' })
vim.keymap.set('n', '<leader>B', ':bd <C-z>', { desc = '[b]uffer [d]elete' })
vim.keymap.set('n', '<leader>j', '<Cmd>jumps<CR>', { desc = '[j]umplist' })
vim.keymap.set('n', '<leader>m', '<Cmd>marks<CR>', { desc = '[m]arks' })
vim.keymap.set('n', '<leader>g', [[:grep ''<Left>]], { desc = '[g]rep text' })
vim.keymap.set('v', '<leader>g', [["0y:grep '<C-r>0'<Left>]], { desc = '[g]rep marked text' })
vim.keymap.set('n', '<leader>G', [[:grep '<C-r><C-w>'<CR><CR>]], { desc = '[G]rep current <cword>' })
