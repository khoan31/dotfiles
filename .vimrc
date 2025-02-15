" disable compatibility with vi which can cause unexpected issues.
set nocompatible

" re-map leader key
nnoremap <space> <nop>
let g:mapleader=' '

" quick exit some filetypes
autocmd! FileType help,qf,diff nnoremap <silent> <buffer> q :q<cr>

" open the quickfix window whenever a quickfix command is executed
autocmd! QuickFixCmdPost [^l]* cwindow

" encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8

" enable type file detection
filetype on
filetype plugin on

" load an indent file for the detected file type.
filetype indent on
filetype plugin indent on

" turn syntax highlighting on.
syntax enable

" show invisible characters
set list
" set the characters for the invisibles
set listchars=tab:⇀\ ,eol:¬,nbsp:␣,trail:⋅
set showbreak=↪

" auto copy indent and auto read file change
set autoindent
set autoread

" allow backspacing over listed items and belloff
set backspace=indent,eol,start
set belloff=all
set visualbell

" scan to put in completion
set complete=.,w,b,u,t

" sequence of letters which describes how automatic formatting is to be done
set formatoptions=tcqj

" add numbers to each line on the left-hand side.
set number
set relativenumber
set ruler
set hidden

" set default indentation
set expandtab
set smarttab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set shiftround

" do not save temporary files.
set nobackup
set noswapfile
set nowrap

" split behaviour
set splitbelow
set splitright
set sidescrolloff=10
set title

" searching
set incsearch
set hlsearch
set matchpairs+=<:>
set ignorecase
set smartcase

" enable mouse interaction
set mouse=a
set mousemodel=popup_setpos

" limit command height to 1 line
set cmdheight=1
set nopaste

" show several useful info
set showcmd
set showmode
set showmatch

" the cursor is kept in the same column
set nostartofline

" this option controls the behavior when switching between buffers
set switchbuf=uselast
set tabpagemax=50

" get rid of scratch buffer
set completeopt-=preview
set ttimeout
set ttimeoutlen=50

" enable auto completion menu after pressing tab.
set wildmode=full
set wildcharm=<c-z>
set wildmenu

" set the commands to save in history default number is 20.
set history=10000
set ttyfast

" basic theming
set background=dark
set fillchars+=vert:│
set laststatus=2

" remap switch region keys
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
" same but from terminal
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l

" re-size split windows using arrow keys
nnoremap <silent> <up> :resize -2<cr>
nnoremap <silent> <right> :vertical resize +2<cr>
nnoremap <silent> <down> :resize +2<cr>
nnoremap <silent> <left> :vertical resize -2<cr>

" dismiss highlight
nnoremap <silent> <esc> :nohlsearch<cr>

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

" Fuzzy find
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

" search and replace
nnoremap <leader>r :%s/<c-r><c-w>//g<left><left>
vnoremap <leader>r "0y:%s/<c-r>0//g<left><left>

" copy, move and remove file
nnoremap <leader>sc :!cp -r %:p<c-z> %:p:h<left><left><left><left><left><left>
nnoremap <leader>sm :!mv %:p<c-z> %:p:h<left><left><left><left><left><left>
nnoremap <leader>sr :!rm -rf %:p<c-z>

" highlight marked files in the same way search matches are
highlight link netrwMarkFile Search

" set basic highlight groups
highlight Statusline cterm=NONE ctermbg=NONE ctermfg=darkgrey
highlight StatuslineNC cterm=NONE ctermbg=NONE ctermfg=grey
highlight VertSplit cterm=NONE ctermbg=NONE ctermfg=darkgrey
