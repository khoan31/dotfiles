" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Re-map leader key
nnoremap <space> <nop>
let g:mapleader=' '

" ----- General settings -----
" Encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" Enable type file detection
filetype on
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on
filetype plugin indent on

if has('mac')
  " ----- Plugin definitions -----
  call plug#begin()

  " List your plugins here
  " Make sure you use single quotes

  " A command-line fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " fugitive.vim: A Git wrapper so awesome, it should be illegal
  Plug 'tpope/vim-fugitive'

  " A Vim plugin which shows git diff markers in the sign column
  Plug 'airblade/vim-gitgutter'

  " Modern database interface for Vim
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'
  Plug 'kristijanhusak/vim-dadbod-completion'

  " Neovim plugin for GitHub Copilot
  Plug 'github/copilot.vim'

  " ----- End plugin definitions -----
  call plug#end()
endif

" Turn syntax highlighting on.
syntax enable

" Add numbers to each line on the left-hand side.
set number
set relativenumber
set ruler
set hidden

" Show invisible characters
set list
" Set the characters for the invisibles
set listchars=tab:›\ ,eol:¬,trail:⋅
set showbreak=↪

" Auto copy indent and auto read file change
set autoindent
set autoread

" Allow backspacing over listed items and belloff
set backspace=indent,eol,start
set belloff=all
set visualbell

" Scan to put in completion
set complete=.,w,b,u,t

" Sequence of letters which describes how automatic formatting is to be done
set formatoptions=tcqj

" Set default indentation
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set shiftround

" Do not save temporary files.
set nobackup
set noswapfile
set wrap

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=50
set splitbelow
set splitright
set title

" Searching
set incsearch
set hlsearch
set matchpairs+=<:>
set ignorecase
set smartcase

" Enable mouse interaction
set mouse=a
set mousemodel=popup_setpos

" Limit command height to 1 line
set cmdheight=1
set nopaste

" Show several useful info
set showcmd
set noshowmode
set showmatch

" The cursor is kept in the same column
set nostartofline

" This option controls the behavior when switching between buffers
set switchbuf=uselast
set tabpagemax=50

" Get rid of scratch buffer
set completeopt-=preview
set ttimeout
set ttimeoutlen=50

" Enable auto completion menu after pressing TAB.
set wildmode=full
set wildcharm=<c-z>

" wildmenu settings
set wildmenu
if has('mac')
  set wildoptions=pum,tagfile
  set wildignore=*.o,*~,*.a,*.so,*.pyc,*.swp,.git/,*.class,*/target/*,*/build/*,.idea/
  set wildignore+=*/Library/*,*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*,*/.DS_Store
endif

" Add C/C++ include to path on MacOS
function s:SetCIncludePath()
  let l:sdk = system('xcrun --show-sdk-path')
  let l:sdk = substitute(l:sdk, '\n', '', 'g')
  execute 'set path+=' . l:sdk . '/usr/include'
  execute 'set path+=' . l:sdk . '/usr/include/c++/v1'
endfunction

" Set include path for C/C++ development on MacOS
if executable('xcrun')
  autocmd FileType c,cpp call <SID>SetCIncludePath()
endif

" Program to use for the :grep command
if executable('rg') > 0
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
endif

" Set the commands to save in history default number is 20.
set history=10000
set ttyfast

" Set statusline style and background
set laststatus=2
set background=light
set fillchars+=vert:│

" Colorscheme
if has('mac')
  set termguicolors
  colorscheme wildcharm
endif

" ----- Highlights -----
" Highlight marked files in the same way search matches are
hi! link netrwMarkFile Search

" ----- Keymaps -----
" Remap switch region keys
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Remap switch region keys within terminal
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

" Re-size split windows using arrow keys
nnoremap <silent> <up> :resize -2<cr>
nnoremap <silent> <right> :vertical resize +2<cr>
nnoremap <silent> <down> :resize +2<cr>
nnoremap <silent> <left> :vertical resize -2<cr>

" Dismiss highlight
nnoremap <silent> H :noh<cr>

" Remap scroll
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Navigate through quickfix list
nnoremap <silent> ]q :cnext<cr>zz
nnoremap <silent> [q :cprev<cr>zz

" Open netrw at current dir
nmap - :Explore<cr>

" Quick exit some filetypes
autocmd! FileType help,qf,diff,fugitive,fugitiveblame,dbout nnoremap <silent> <buffer> q :q<CR>
autocmd! FileType netrw nnoremap <silent> <buffer> x :Rexplore<cr>

" Indentation by filetypes
autocmd FileType c,cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" Run current java test file
function s:RunMavenTest()
  let l:dirs = split(@%, '[/]')

  if index(l:dirs, 'test') < 0
    echo 'Not a test file!'
    return
  endif

  let l:module = l:dirs[0] != 'src' ? l:dirs[0] : ''
  let l:test_class = join(l:dirs[4 : ], '.')[ : -6 ]

  execute('silent !mvn test -pl :' .. module .. ' -Dtest=' .. test_class .. ' -DskipTests=false')
endfunction
autocmd FileType java nnoremap <leader>T :call <SID>RunMavenTest()<CR>

" Search current marked text
vnoremap // y/\V<c-r>=escape(@",'/\')<cr><cr>

" Copy marked text/paste to/from global register
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

" Fuzzy find
nmap <leader>f :find **/*
vmap <leader>f "0y:find **/<c-r>0*<c-z>
nmap <leader>F :e <c-z>
nmap <leader>b :b <c-z>
nmap <leader>j :jumps<cr>
nmap <leader>m :marks<cr>
nmap <leader>g :grep ''<left>
vmap <leader>g "0y:grep '<c-r>0'<left>
nmap <leader>G :set grepprg=<c-z>
nmap <leader>s :grep '<c-r>+'<left>

" Search and replace
nnoremap <leader>r :%s/<c-r><c-w>//g<left><left>
vnoremap <leader>r "5y<esc>:%s/<c-r>5//g<left><left>

" Open the quickfix window whenever a quickfix command is executed
autocmd! QuickFixCmdPost [^l]* cwindow

if has('mac')
  " Fzf options
  let g:fzf_vim = {}
  let g:fzf_vim.preview_window = []
  let g:fzf_layout = { 'down': '41%' }
  " Fzf keymaps
  augroup fzf_keymaps
    autocmd!
    nnoremap <leader>f :Files<CR>
    nnoremap <leader>F :GFiles<CR>
    nnoremap <leader>b :Buffers<CR>
    nnoremap <leader>j :Jumps<CR>
    nnoremap <leader>m :Marks<CR>
    nnoremap <leader>g :Rg<CR>
    vnoremap <leader>f "0y":Files <C-r>0<CR>
    vnoremap <leader>g "0y:Rg <C-r>0<CR>
  augroup END
  " Fzf highlight groups
  highlight! fzf1 ctermfg=grey ctermbg=NONE
  highlight! fzf2 ctermfg=grey ctermbg=NONE
  highlight! fzf3 ctermfg=grey ctermbg=NONE

  " Gitgutter keymaps
  augroup gitgutter_keymaps
    autocmd!
    nmap ]h <Plug>(GitGutterNextHunk)
    nmap [h <Plug>(GitGutterPrevHunk)
  augroup END
  " Gitgutter highlight group
  highlight! link SignColumn LineNr

  " Dadbod UI keymap
  nnoremap <leader>db :DBUIToggle<CR>

  " Copilot options
  let g:copilot_enabled = 0
  " let g:copilot_no_tab_map = v:true
  " inoremap <silent><script><expr> <c-e> copilot#Accept('\<cr>')
endif

" Set basic highlight groups
highlight! Statusline cterm=NONE ctermbg=grey ctermfg=black guibg=grey guifg=black
highlight! StatuslineNC cterm=NONE ctermbg=lightgrey ctermfg=grey guibg=lightgrey guifg=darkgrey
highlight! VertSplit cterm=NONE ctermbg=NONE
highlight! Visual ctermbg=blue ctermfg=white
