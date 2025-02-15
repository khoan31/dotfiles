" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Re-map leader key
nnoremap <Space> <Nop>
let g:mapleader=' '

" ----- Autocommands -----
" Quick exit some filetypes
autocmd! FileType help,qf,diff nnoremap <silent> <buffer> q :q<CR>

" Indentation by filetypes
autocmd FileType c,cpp setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
autocmd FileType javascript,typescript setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab

" Open the quickfix window whenever a quickfix command is executed
autocmd! QuickFixCmdPost [^l]* cwindow

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

" Turn syntax highlighting on.
syntax enable

" Show invisible characters
set list
" Set the characters for the invisibles
set listchars=tab:⇀\ ,eol:¬,nbsp:␣,trail:⋅
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

" Add numbers to each line on the left-hand side.
set number
set relativenumber
set ruler
set hidden

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
set nowrap

" Split behaviour
set splitbelow
set splitright
set sidescrolloff=10
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
set wildcharm=<C-z>

" wildmenu settings
set wildmenu
set wildoptions=pum,tagfile

" Program to use for the :grep command
if executable('rg') > 0
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
endif

" Set the commands to save in history default number is 20.
set history=10000
set ttyfast

" Basic theming
set background=dark
set fillchars+=vert:│
set laststatus=2

" ----- Keymaps -----
" Remap switch region keys
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Remap switch region keys within terminal
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Re-size split windows using arrow keys
nnoremap <silent> <Up> :resize -2<CR>
nnoremap <silent> <Right> :vertical resize +2<CR>
nnoremap <silent> <Down> :resize +2<CR>
nnoremap <silent> <Left> :vertical resize -2<CR>

" Dismiss highlight
nnoremap <silent> <Esc> :nohlsearch<CR>

" Navigate through quickfix list
nnoremap <silent> ]q :cnext<CR>zz
nnoremap <silent> [q :cprev<CR>zz

" Search current marked text
vnoremap // y/\V<C-r>=escape(@",'/\')<CR><CR>

" Copy marked text/paste to/from global register
nnoremap <leader>Y "+Y
vnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p

" Fuzzy find
nmap <leader>f :find **/*
vmap <leader>f "0y:find **/*<C-r>0<C-z>
nmap <leader>F :find **/*<C-r><C-w><C-z>
nmap <leader>e :e %:p:h<C-z>
nmap <leader>b :b <C-z>
nmap <leader>B :bd <C-z>
nmap <leader>j :jumps<CR>
nmap <leader>m :marks<CR>
nmap <leader>g :grep ''<Left>
vmap <leader>g "0y:grep '<C-r>0'<Left>
nmap <leader>G :grep '<C-r><C-w>'<CR><CR>

" Search and replace
nnoremap <leader>r :%s/<C-r><C-w>//g<Left><Left>
vnoremap <leader>r "0y:%s/<C-r>0//g<Left><Left>

" Copy, move and remove file
nnoremap <leader>sc :!cp -r %:p<C-z> %:p:h<Left><Left><Left><Left><Left><Left>
nnoremap <leader>sm :!mv %:p<C-z> %:p:h<Left><Left><Left><Left><Left><Left>
nnoremap <leader>sr :!rm -rf %:p<C-z>

" ----- Highlights -----
" Highlight marked files in the same way search matches are
highlight link netrwMarkFile Search

" Set basic highlight groups
highlight Statusline cterm=NONE ctermbg=NONE ctermfg=darkgrey
highlight StatuslineNC cterm=NONE ctermbg=NONE ctermfg=grey
highlight VertSplit cterm=NONE ctermbg=NONE ctermfg=darkgrey
