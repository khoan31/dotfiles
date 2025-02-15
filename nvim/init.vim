" open the quickfix window whenever a quickfix command is executed
autocmd! QuickFixCmdPost [^l]* cwindow

" quick exit some filetypes
autocmd! FileType help,qf,diff,fugitive,fugitiveblame nnoremap <silent> <buffer> q :q<cr>
autocmd! FileType checkhealth,dbout nnoremap <silent> <buffer> q :bd<cr>

" highlight when yanking (copying) text
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua vim.hl.on_yank({higroup='Visual',timeout=300})
augroup END

" ==============================================================================
" general settings / options
" ==============================================================================
set encoding=utf-8
set fileencoding=utf-8

" show invisible characters
set list
" set the characters for the invisibles
set listchars=tab:⇀\ ,eol:¬,nbsp:␣,trail:⋅
set showbreak=↪

" enable break indent
set breakindent
set visualbell

" add numbers to each line on the left-hand side.
set number
set relativenumber
set ruler
set hidden

" set default indentation
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set shiftround
set smarttab

" do not save temporary files.
set nobackup
set noswapfile
set nowrap

" split behaviour
set splitbelow
set splitright

" enable title string and sidescrolloff
set title
set sidescrolloff=10

" characters that form pairs
set matchpairs+=<:>
set nopaste

" case-insensitive searching UNLESS \C or one or more capital letters in the search term
set ignorecase
set smartcase
set inccommand=split

" save undo history
set undofile
set tabpagemax=50

" show mode and match
set showmode
set showmatch

" cursorline, the cursor is kept in the same column
set cursorline
set nostartofline

" enable auto completion menu after pressing TAB.
set wildmode=full
set wildcharm=<c-z>
set wildmenu

" program to use for the :grep command
if executable('rg') > 0
  set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case\ --column\ --hidden\ --no-ignore
endif

" set the commands to save in history default number is 20.
set history=10000

" basic theming
set background=dark
set termguicolors
set laststatus=2

" re-map leader key
nnoremap <space> <nop>
let g:mapleader=' '

" ==============================================================================
" plugins
" ==============================================================================
call plug#begin()
" the default plugin directory will be as follows:
"   - vim (linux/macos): '~/.vim/plugged'
"   - vim (windows): '~/vimfiles/plugged'
"   - neovim (linux/macos/windows): stdpath('data') . '/plugged'
" you can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - avoid using standard vim directory names like 'plugin'

" make sure you use single quotes

" nvim-treesitter configurations and abstraction layer
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" xcode colourscheme for vim 
Plug 'lunacookies/vim-colors-xcode'

" find, filter, preview, pick
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }

" a git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" delete/change/add parentheses/quotes/xml-tags/much more with ease
Plug 'tpope/vim-surround'

" modern database interface for vim
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'

" easily install and manage lsp servers, dap servers, linters, and formatters
Plug 'williamboman/mason.nvim'

" extensions for the built-in lsp support in neovim for eclipse.jdt.ls
Plug 'mfussenegger/nvim-jdtls'

" github copilot
Plug 'github/copilot.vim'

" call plug#end to update &runtimepath and initialize the plugin system.
" - it automatically executes `filetype plugin indent on` and `syntax enable`
call plug#end()
" you can revert the settings after the call like so:
"   filetype indent off   " disable file-type-specific indentation
"   syntax off            " disable syntax highlighting

" ==============================================================================
" command and autocmds
" ==============================================================================
" create session directory if not exist
function! s:get_session_dir() abort
  let l:session_dir = stdpath('data') . '/sessions'

  if !isdirectory(l:session_dir)
    call mkdir(l:session_dir, 'p')
  endif

  return l:session_dir
endfunction

" make session automatically when save a buffer or exit vim
function! s:auto_make_session() abort
  if !empty(argv()) && argv(0) != getcwd()
    return
  endif

  let l:session_dir = <sid>get_session_dir()
  let l:session_name = fnamemodify(getcwd(), ':p:h:t')

  execute 'silent! mksession! ' . l:session_dir . '/' . l:session_name . '.vim'
endfunction

augroup vim_sessionizer
  autocmd!
  autocmd BufWritePost,VimLeavePre * call <sid>auto_make_session()
augroup END

" load session automatically when start vim
function! s:auto_source_session() abort
  if !empty(argv()) && argv(0) != getcwd()
    return
  endif

  let l:session_dir = <sid>get_session_dir()
  let l:session_name = fnamemodify(getcwd(), ':p:h:t')
  let l:session_file = l:session_dir . '/' . l:session_name . '.vim'

  if filereadable(l:session_file)
    let l:choice = confirm("", "load last session? &yes\n&no\n&clear", 2, "Question")
    if l:choice == 1
      execute 'silent! source ' . l:session_file
    elseif l:choice == 3
      call delete(l:session_file)
    endif
  endif
endfunction

augroup vim_session
  autocmd!
  autocmd VimEnter * call <sid>auto_source_session()
augroup END

" ==============================================================================
" keymaps
" ==============================================================================
nnoremap <silent> <esc> :nohlsearch<cr>

" use ctrl+<hjkl> to switch between windows
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
" same but between terminals
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

" re-size split windows using arrow keys
nnoremap <silent> <up> :resize -2<cr>
nnoremap <silent> <right> :vertical resize +2<cr>
nnoremap <silent> <down> :resize +2<cr>
nnoremap <silent> <left> :vertical resize -2<cr>

" navigate through quickfix list
nnoremap <silent> ]q :cnext<cr>zz
nnoremap <silent> [q :cprev<cr>zz

" search current marked text
vnoremap // y/\v<c-r>=escape(@",'/\')<cr><cr>

" copy marked text/paste to/from global register
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

" default fuzzy find
nmap <leader>f :find **/*
vmap <leader>f "0y:find **/*<c-r>0<c-z>
nmap <leader>F :find **/*<c-r><c-w><c-z>
nmap <leader>e :e %:p:h<c-z>
nmap <leader>b :b <c-z>
nmap <leader>B :bd <c-z>
nmap <leader>j :jumps<cr>
nmap <leader>m :marks<cr>
nmap <leader>g :grep ''<left>
vmap <leader>g "0y:grep '<c-r>0'<left>
nmap <leader>G :grep '<c-r><c-w>'<cr><cr>

" find and replace
nnoremap <leader>r :%s/<c-r><c-w>//g<left><left>
vnoremap <leader>r "0y:%s/<c-r>0//g<left><left>

" copy, move and remove file
nnoremap <leader>C :!cp -r %:p<c-z> %:p:h<left><left><left><left><left><left>
nnoremap <leader>M :!mv %:p<c-z> %:p:h<left><left><left><left><left><left>
nnoremap <leader>R :!rm -rf %:p<c-z>

" ==============================================================================
" plugins configuration
" ==============================================================================
" color schemes should be loaded after plug#end().
" we prepend it with 'silent!' to ignore errors when it's not yet installed.
silent! colorscheme xcodedarkhc

" nvim-treesitter
lua require('nvim-treesitter.configs').setup({auto_install=true,highlight={enable=true},indent={enable=true}})
lua require('mason').setup()

" telescope
lua require('telescope').setup({defaults={layout_strategy='bottom_pane',layout_config={height=0.41,preview_cutoff=543}}})
" keymaps
" files
nnoremap <leader>f <cmd>lua require('telescope.builtin').find_files()<cr>
vnoremap <leader>f "0y:lua require('telescope.builtin').find_files({search_file='<c-r>0'})<cr>
nnoremap <leader>F <cmd>lua require('telescope.builtin').find_files({search_file=vim.fn.expand('<cword>')})<cr>
nnoremap <leader>s <cmd>lua require('telescope.builtin').git_files()<cr>
" grep
nnoremap <leader>g <cmd>lua require('telescope.builtin').live_grep()<cr>
vnoremap <leader>g "0y:lua require('telescope.builtin').grep_string({search='<c-r>0'})<cr>
nnoremap <leader>G <cmd>lua require('telescope.builtin').grep_string({search=vim.fn.expand('<cword>')})<cr>
" misc
nnoremap <leader>j <cmd>lua require('telescope.builtin').jumplist()<cr>
nnoremap <leader>m <cmd>lua require('telescope.builtin').marks()<cr>
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>o <cmd>lua require('telescope.builtin').resume()<cr>

" disable copilot by default
let g:copilot_enabled=0

" ==============================================================================
" highlights
" ==============================================================================
highlight link netrwMarkFile Search

" set basic highlight groups
highlight Statusline cterm=NONE guibg=NONE guifg=darkgrey
highlight StatuslineNC cterm=NONE guibg=NONE guifg=grey
highlight WinSeparator cterm=NONE guibg=NONE guifg=grey
