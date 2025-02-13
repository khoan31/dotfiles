-- Enables the experimental Lua module loader
vim.loader.enable()

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = true
vim.opt.wrap = false

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable break indent
vim.opt.breakindent = true

-- Enable title string and cursorline
vim.opt.title = true
vim.opt.cursorline = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 500

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.opt.list = true
vim.opt.listchars = { tab = 'ǀ ', trail = '·', eol = '¬', nbsp = '␣' }
vim.opt.showbreak = '↪'

-- Set default indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftround = true

-- Do not save temporary files.
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.wrap = false

-- Do not let cursor scroll surpass N number of columns when side scrolling.
vim.opt.sidescrolloff = 10

-- Get rid of preview buffer
vim.opt.completeopt:remove('preview')

-- Config wildmenu
vim.opt.wildignore = '*.o,*~,*.a,*.so,*.pyc,*.swp,*/.git/*,*.class'

-- Limit command height to 1 line
vim.opt.cmdheight = 1
vim.opt.paste = false

-- No global status
vim.opt.laststatus = 2

-- Basic theme
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- Program to use for the :grep command
if vim.fn.executable('rg') > 0 then
   vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden --no-ignore'
else
   print('No ripgrep installation found!')
end

-- Make sure to setup `mapleader` and `maplocalleader` before
vim.g.mapleader = ' '

-- Load other modules
require('keymaps')
require('autocmds')
require('plugins')

-- Highlight marked files in the same way search matches are
vim.api.nvim_set_hl(0, 'netrwMarkFile', { link = 'Search' })

-- Basic highlights
vim.api.nvim_set_hl(0, 'Statusline', { bg = 'NONE', fg = 'darkgrey' })
vim.api.nvim_set_hl(0, 'StatuslineNC', { bg = 'NONE', fg= 'grey' })
